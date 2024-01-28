-- vim: foldmethod=marker

-- General goals:
-- - Be extra minimal for `notermguicolors` while allowing more shades for
--   when `termguicolors` is set.
-- - Be accessible, i.e. have enough contrast ratios (CR):
--     - Fully passable `Normal` highlight group: CR>=7.
--     - Passable `Visual` highlight group (with `Normal` foreground): CR>=4.5.
--     - Passable comment in current line (foreground from `Comment` and
--       background from `CursorLine`): CR>=4.5.
--     - Passable diff highlight groups: CR>=4.5.
--     - Passable 'Search' highlight group: CR>=4.5.
-- - Have dark and light variants be a simple exchange of dark and light
--   palettes (as this is easier to implement).
-- - Be usable for more than one person.

-- Setup {{{1
-- NOTE: All manipulation is done in Oklch color space.
-- Get interactive view at https://bottosson.github.io/misc/colorpicker/
-- Install https://github.com/echasnovski/mini.colors to have this working
local success, colors = pcall(require, "mini.colors")
if not success then
  vim.notify("Could not require mini.colors.", vim.log.levels.ERROR)
  return
end

-- WHETHER TO OPEN A BUFFER WITH DATA
local show_preview_buffer = true

-- WHETHER TO APPLY CURRENT COLOR SCHEME
local apply_colorscheme = false

-- Hyperparameters {{{1

--- REFERENCE LIGHTNESS VALUES
--- They are applied both to dark and light pallete, and indicate how far from
--- corresponding edge (0 for dark and 100 for light) it should be.
--- Level meaning for dark color scheme (reverse for light one):
--- - Level 1 is background for floating windows.
--- - Level 2 is basic lightness. Used in `Normal` (both bg and fg).
--- - Level 3 is `CursorLine` background.
--- - Level 4 is `Visual` background and `Comment` foreground.
---
--- Value for level 2 is taken from #14790 (as lightness of #1e1e1e).
--- Others are the result of experiments to have passable contrast ratios.
local L = { 2, 6, 13, 20, 35 }

--- REFERENCE CHROMA VALUES
--- Chosen experimentally. Darker colors usually need higher chroma to appear
--- visibly different (combined with proper gamut clipping)
local C = { grey = 0, desat = 1, light = 10, dark = 15 }

--- REFERENCE HUE VALUES
--- - Grey is used for UI background and foreground. It is not exactly an
---   achromatic grey, but a "colored grey" (very desaturated colors). It adds
---   at least some character to the color scheme.
---   Choice 270 implements "cold" UI. Tweak to get a different feel. Examples:
---     - 90 for warm.
---     - 180 for neutral cyan.
---     - 0 for neutral pink.
--- - Red hue is taken roughly the same as in reference #D96D6A
--- - Green hue is taken roughly the same as in reference #87FFAF
--- - Cyan hue is taken roughly the same as in reference #00E6E6
--- - Yellow, blue, and magenta are chosen to be visibly different from others.
local H = {
  pink = 0,
  red = 25,
  amber = 60,
  brown = 60,
  orange = 70,
  yellow = 90,
  green = 150,
  cyan = 195,
  blue = 240,
  grey = 270,
  purple = 300,
  magenta = 330,
}

--- SEMANITC HUE VALUES
--- These are not just hue constants, but associations of semantig objects to
--- hues.
local SH = {
  neutral = H.grey,
  interact = H.cyan,
  insert = H.blue,
  replace = H.amber,
  modified = H.purple,
  diff = {
    added = H.green,
    changed = H.amber,
    deleted = H.red,
    text = H.orange,
  },
  syntax = {
    namespace = H.brown,
  },
}

-- Palettes {{{1

local function convert(l, c, h)
  return colors.convert({ l = l, c = c, h = h }, "hex", {
    gamut_clip = "chroma",
  })
end

local function round(x)
  return math.floor(10 * x + 0.5) / 10
end

--stylua: ignore
local palette_dark = {
  grey1   = convert(L[1],       C.grey,  SH.neutral), -- NormalFloat
  grey2   = convert(L[2],       C.grey,  SH.neutral), -- Normal bg
  grey3   = convert(L[3],       C.grey,  SH.neutral), -- CursorLine
  grey4   = convert(L[4],       C.grey,  SH.neutral), -- Visual

  red     = convert(L[2],       C.dark,  H.red),      -- DiffDelete
  yellow  = convert(L[2],       C.dark,  H.yellow),   -- Search
  green   = convert(L[2],       C.dark,  H.green),    -- DiffAdd
  cyan    = convert(L[2],       C.dark,  H.cyan),     -- DiffChange
  blue    = convert(L[2],       C.dark,  H.blue),
  magenta = convert(L[2],       C.dark,  H.magenta),
}

--stylua: ignore
local palette_light = {
  grey1   = convert(100 - L[1], C.grey,  SH.neutral),
  grey2   = convert(100 - L[2], C.grey,  SH.neutral), -- Normal fg
  grey3   = convert(100 - L[3], C.grey,  SH.neutral),
  grey4   = convert(100 - L[4], C.grey,  SH.neutral), -- Comment

  red     = convert(100 - L[2], C.light, H.red),      -- DiagnosticError
  yellow  = convert(100 - L[2], C.light, H.yellow),   -- DiagnosticWarn
  green   = convert(100 - L[2], C.light, H.green),    -- String,     DiagnosticOk
  cyan    = convert(100 - L[2], C.light, H.cyan),     -- Function,   DiagnosticInfo
  blue    = convert(100 - L[2], C.light, H.blue),     -- Identifier, DiagnosticHint
  magenta = convert(100 - L[2], C.light, H.magenta),
}

-- Data {{{1

--- @class HighlightData
--- @field spec vim.api.keyset.highlight
--- @field contrast? number

--- @type table<string, vim.api.keyset.highlight>
local highlights_dark = {
  Cursor = { bg = palette_dark.cyan },
  Normal = { fg = palette_light.grey1, bg = palette_dark.grey1 },
}

--- @type table<string, vim.api.keyset.highlight>
local highlights_light = {
  Cursor = { bg = palette_light.cyan },
  Normal = { fg = palette_dark.grey1, bg = palette_light.grey1 },
}

--- @param highlights table<string, vim.api.keyset.highlight>
--- @return table<string, HighlightData>
local function map_specs(highlights)
  local data = {}

  for key, value in pairs(highlights) do
    if value.fg then
      value.ctermfg = require("mini.colors").convert(value.fg, "8-bit")
    end
    if value.bg then
      value.ctermbg = require("mini.colors").convert(value.bg, "8-bit")
    end

    data[key] = { spec = value }
  end

  return data
end

local data_dark = map_specs(highlights_dark)
local data_light = map_specs(highlights_light)

-- Contrast ratios {{{1
local function correct_channel(x)
  return x <= 0.04045 and (x / 12.92) or math.pow((x + 0.055) / 1.055, 2.4)
end

-- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
local function get_luminance(hex)
  local rgb = colors.convert(hex, "rgb") --[[@as table]]

  -- Convert decimal color to [0; 1]
  local r, g, b = rgb.r / 255, rgb.g / 255, rgb.b / 255

  -- Correct channels
  local R, G, B = correct_channel(r), correct_channel(g), correct_channel(b)

  return 0.2126 * R + 0.7152 * G + 0.0722 * B
end

-- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef
--- @param highlights table<string, HighlightData>
local function add_contrast_ratios(highlights)
  for key, value in pairs(highlights) do
    if value.spec.link then
      return
    end

    local lum_fg, lum_bg =
      get_luminance(value.spec.fg or highlights.Normal.spec.fg),
      get_luminance(value.spec.bg or highlights.Normal.spec.bg)
    local res = (math.max(lum_bg, lum_fg) + 0.05)
      / (math.min(lum_bg, lum_fg) + 0.05)
    -- Track only one decimal digit
    highlights[key].contrast = round(res)
  end
end

add_contrast_ratios(data_dark)
add_contrast_ratios(data_light)

-- Preview buffer {{{1

--- @param hls table<string, HighlightData>
local function create_preview_lines(lines, hls)
  local keys = vim.tbl_keys(hls)
  table.sort(keys)

  for _, key in ipairs(keys) do
    table.insert(
      lines,
      string.format(
        "XXX %-20s %4.1f %7s %7s %7s %3s %3s",
        key,
        hls[key].contrast,
        hls[key].spec.fg,
        hls[key].spec.bg,
        hls[key].spec.special,
        hls[key].spec.ctermfg,
        hls[key].spec.ctermbg
      )
    )
  end
end

local function highlight_preview_lines(
  buf_id,
  ext_ns,
  offset,
  hls,
  normal,
  suffix
)
  local keys = vim.tbl_keys(hls)
  table.sort(keys)

  for index, key in ipairs(keys) do
    local name = key .. "_preview_" .. suffix

    local spec = vim.tbl_extend("keep", hls[key], normal)

    vim.api.nvim_set_hl(0, name, spec)
    vim.api.nvim_buf_add_highlight(buf_id, ext_ns, name, index + offset, 0, 3)
  end
end

local function create_preview_buffer()
  local ext_ns = vim.api.nvim_create_namespace "highlight-previews-extmarks"
  local buf_id = vim.api.nvim_create_buf(true, true)

  local lines = {}

  vim.list_extend(lines, { "source lua/color-tool.lua" })
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "--- Highlights ---" })
  vim.list_extend(lines, { "Dark:" })
  create_preview_lines(lines, data_dark)
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "Light:" })
  create_preview_lines(lines, data_light)
  vim.list_extend(lines, { "", "" })

  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  highlight_preview_lines(
    buf_id,
    ext_ns,
    3,
    highlights_dark,
    highlights_dark.Normal,
    "dark"
  )
  highlight_preview_lines(
    buf_id,
    ext_ns,
    3 + #highlights_dark + 4,
    highlights_light,
    highlights_light.Normal,
    "light"
  )
  vim.api.nvim_set_current_buf(buf_id)
end

if show_preview_buffer then
  create_preview_buffer()
end

-- Highlight groups {{{1

local function enable_colorscheme()
  vim.cmd.highlight "clear"
  vim.g.colors_name = "new_colors"

  -- In 'background=dark' dark colors are used for background and light - for
  -- foreground. In 'background=light' they reverse.
  -- Inline comments show basic highlight group assuming dark background

  local is_dark = vim.o.background == "dark"
  local bg = is_dark and palette_dark or palette_light
  local fg = is_dark and palette_light or palette_dark
  local hls = is_dark and data_dark or data_light

  -- Source for actual groups: 'src/nvim/highlight_group.c' in Neovim source code
  local function hi(name, data)
    vim.api.nvim_set_hl(0, name, data)
  end

  for key, value in pairs(hls) do
    hi(key, value.spec)
  end

  --stylua: ignore start
  -- General UI
  hi('ColorColumn',          { fg = nil,     bg = bg.grey4 })
  hi('Conceal',              { fg=bg.grey4,  bg=nil })
  hi('CurSearch',            { link='Search' })
  hi('CursorColumn',         { fg=nil,       bg=bg.grey3 })
  hi('CursorIM',             { link='Cursor' })
  hi('CursorLine',           { fg=nil,       bg=bg.grey3 })
  hi('CursorLineFold',       { link='FoldColumn' })
  hi('CursorLineNr',         { fg=nil,       bg=nil,      bold=true })
  hi('CursorLineSign',       { link='SignColumn' })
  hi('DiffAdd',              { fg=fg.grey1,  bg=bg.green })
  hi('DiffChange',           { fg=fg.grey1,  bg=bg.grey4 })
  hi('DiffDelete',           { fg=fg.red,    bg=nil,      bold=true })
  hi('DiffText',             { fg=fg.grey1,  bg=bg.cyan })
  hi('Directory',            { fg=fg.cyan,   bg=nil })
  hi('EndOfBuffer',          { link='NonText' })
  hi('ErrorMsg',             { fg=fg.red,    bg=nil })
  hi('FloatBorder',          { link='NormalFloat' })
  hi('FloatShadow',          { fg=bg.grey1,  bg=nil,      blend=80 })
  hi('FloatShadowThrough',   { fg=bg.grey1,  bg=nil,      blend=100 })
  hi('FloatTitle',           { link='Title' })
  hi('FoldColumn',           { link='SignColumn' })
  hi('Folded',               { fg=fg.grey4,  bg=bg.grey3 })
  hi('IncSearch',            { link='Search' })
  hi('lCursor',              { fg=bg.grey2,  bg=fg.grey2 })
  hi('LineNr',               { fg=bg.grey4,  bg=nil })
  hi('LineNrAbove',          { link='LineNr' })
  hi('LineNrBelow',          { link='LineNr' })
  hi('MatchParen',           { fg=nil,       bg=bg.grey4, bold=true })
  hi('ModeMsg',              { fg=fg.green,  bg=nil })
  hi('MoreMsg',              { fg=fg.cyan,   bg=nil })
  hi('MsgArea',              { fg=nil,       bg=nil })
  hi('MsgSeparator',         { link='StatusLine' })
  hi('NonText',              { fg=bg.grey4,  bg=nil })
  hi('NormalFloat',          { fg=fg.grey2,  bg=bg.grey1 })
  hi('NormalNC',             { fg=nil,       bg=nil })
  hi('PMenu',                { fg=fg.grey2,  bg=bg.grey3 })
  hi('PMenuExtra',           { link='PMenu' })
  hi('PMenuExtraSel',        { link='PMenuSel' })
  hi('PMenuKind',            { link='PMenu' })
  hi('PMenuKindSel',         { link='PMenuSel' })
  hi('PMenuSbar',            { link='PMenu' })
  hi('PMenuSel',             { fg=bg.grey3,  bg=fg.grey2, blend=0 })
  hi('PMenuThumb',           { fg=nil,       bg=bg.grey4 })
  hi('Question',             { fg=fg.cyan,   bg=nil })
  hi('QuickFixLine',         { fg=nil,       bg=nil,      bold=true })
  hi('RedrawDebugNormal',    { fg=nil,       bg=nil,      reverse=true })
  hi('RedrawDebugClear',     { fg=nil,       bg=bg.cyan })
  hi('RedrawDebugComposed',  { fg=nil,       bg=bg.green })
  hi('RedrawDebugRecompose', { fg=nil,       bg=bg.red })
  hi('Search',               { fg=fg.grey1,  bg=bg.yellow})
  hi('SignColumn',           { fg=bg.grey4,  bg=nil })
  hi('SpecialKey',           { fg=bg.grey4,  bg=nil })
  hi('SpellBad',             { fg=nil,       bg=nil,      sp=fg.red,    undercurl=true })
  hi('SpellCap',             { fg=nil,       bg=nil,      sp=fg.yellow, undercurl=true })
  hi('SpellLocal',           { fg=nil,       bg=nil,      sp=fg.green,  undercurl=true })
  hi('SpellRare',            { fg=nil,       bg=nil,      sp=fg.cyan,   undercurl=true })
  hi('StatusLine',           { fg=fg.grey3,  bg=bg.grey1 })
  hi('StatusLineNC',         { fg=fg.grey4,  bg=bg.grey1 })
  hi('Substitute',           { link='Search' })
  hi('TabLine',              { fg=fg.grey3,  bg=bg.grey1 })
  hi('TabLineFill',          { link='Tabline' })
  hi('TabLineSel',           { fg=nil,       bg=nil,      bold = true })
  hi('TermCursor',           { fg=nil,       bg=nil,      reverse=true })
  hi('TermCursorNC',         { fg=nil,       bg=nil,      reverse=true })
  hi('Title',                { fg=nil,       bg=nil,      bold=true })
  hi('VertSplit',            { link='WinSeparator' })
  hi('Visual',               { fg=nil,       bg=bg.grey4 })
  hi('VisualNOS',            { link='Visual' })
  hi('WarningMsg',           { fg=fg.yellow, bg=nil })
  hi('Whitespace',           { link='NonText' })
  hi('WildMenu',             { link='PMenuSel' })
  hi('WinBar',               { link='StatusLine' })
  hi('WinBarNC',             { link='StatusLineNC' })
  hi('WinSeparator',         { link='Normal' })

  -- Syntax (`:h group-name`)
  hi('Comment', { fg=fg.grey4, bg=nil })

  hi('Constant',  { fg=fg.grey2, bg=nil })
  hi('String',    { fg=fg.green, bg=nil })
  hi('Character', { link='Constant' })
  hi('Number',    { link='Constant' })
  hi('Boolean',   { link='Constant' })
  hi('Float',     { link='Number' })

  hi('Identifier', { fg=fg.blue, bg=nil }) -- frequent but important to get "main" branded color
  hi('Function',   { fg=fg.cyan, bg=nil }) -- not so frequent but important to get "main" branded color

  hi('Statement',   { fg=fg.grey2, bg=nil, bold=true }) -- bold choice (get it?) for accessibility
  hi('Conditional', { link='Statement' })
  hi('Repeat',      { link='Statement' })
  hi('Label',       { link='Statement' })
  hi('Operator',    { fg=fg.grey2, bg=nil }) -- seems too much to be bold for mostly singl-character words
  hi('Keyword',     { link='Statement' })
  hi('Exception',   { link='Statement' })

  hi('PreProc',   { fg=fg.grey2, bg=nil })
  hi('Include',   { link='PreProc' })
  hi('Define',    { link='PreProc' })
  hi('Macro',     { link='PreProc' })
  hi('PreCondit', { link='PreProc' })

  hi('Type',         { fg=fg.grey2, bg=nil })
  hi('StorageClass', { link='Type' })
  hi('Structure',    { link='Type' })
  hi('Typedef',      { link='Type' })

  hi('Special',        { fg=fg.grey2, bg=nil })
  hi('Tag',            { link='Special' })
  hi('SpecialChar',    { link='Special' })
  hi('Delimiter',      { fg=nil,      bg=nil })
  hi('SpecialComment', { link='Special' })
  hi('Debug',          { link='Special' })

  hi('LspInlayHint',   { link='NonText' })
  hi('SnippetTabstop', { link='Visual'  })

  hi('Underlined', { fg=nil,      bg=nil, underline=true })
  hi('Ignore',     { link='Normal' })
  hi('Error',      { fg=bg.grey1, bg=fg.red })
  hi('Todo',       { fg=fg.grey1, bg=nil, bold=true })

  hi('diffAdded',   { fg=fg.green, bg=nil })
  hi('diffRemoved', { fg=fg.red,   bg=nil })

  -- Built-in diagnostic
  hi('DiagnosticError', { fg=fg.red,    bg=nil })
  hi('DiagnosticWarn',  { fg=fg.yellow, bg=nil })
  hi('DiagnosticInfo',  { fg=fg.cyan,   bg=nil })
  hi('DiagnosticHint',  { fg=fg.blue,   bg=nil })
  hi('DiagnosticOk',    { fg=fg.green,  bg=nil })

  hi('DiagnosticUnderlineError', { fg=nil, bg=nil, sp=fg.red,    underline=true })
  hi('DiagnosticUnderlineWarn',  { fg=nil, bg=nil, sp=fg.yellow, underline=true })
  hi('DiagnosticUnderlineInfo',  { fg=nil, bg=nil, sp=fg.cyan,   underline=true })
  hi('DiagnosticUnderlineHint',  { fg=nil, bg=nil, sp=fg.blue,   underline=true })
  hi('DiagnosticUnderlineOk',    { fg=nil, bg=nil, sp=fg.green,  underline=true })

  hi('DiagnosticFloatingError', { fg=fg.red,    bg=bg.grey1 })
  hi('DiagnosticFloatingWarn',  { fg=fg.yellow, bg=bg.grey1 })
  hi('DiagnosticFloatingInfo',  { fg=fg.cyan,   bg=bg.grey1 })
  hi('DiagnosticFloatingHint',  { fg=fg.blue,   bg=bg.grey1 })
  hi('DiagnosticFloatingOk',    { fg=fg.green,  bg=bg.grey1 })

  hi('DiagnosticVirtualTextError', { link='DiagnosticError' })
  hi('DiagnosticVirtualTextWarn',  { link='DiagnosticWarn' })
  hi('DiagnosticVirtualTextInfo',  { link='DiagnosticInfo' })
  hi('DiagnosticVirtualTextHint',  { link='DiagnosticHint' })
  hi('DiagnosticVirtualTextOk',    { link='DiagnosticOk' })

  hi('DiagnosticSignError', { link='DiagnosticError' })
  hi('DiagnosticSignWarn',  { link='DiagnosticWarn' })
  hi('DiagnosticSignInfo',  { link='DiagnosticInfo' })
  hi('DiagnosticSignHint',  { link='DiagnosticHint' })
  hi('DiagnosticSignOk',    { link='DiagnosticOk' })

  hi('DiagnosticDeprecated',  { fg=nil, bg=nil, sp=fg.red, strikethrough=true })
  hi('DiagnosticUnnecessary', { link='Comment' })

  -- Tree-sitter
  -- - Text
  hi('@text.literal',   { link='Comment' })
  hi('@text.reference', { link='Identifier' })
  hi('@text.title',     { link='Title' })
  hi('@text.uri',       { link='Underlined' })
  hi('@text.underline', { link='Underlined' })
  hi('@text.todo',      { link='Todo' })

  -- - Miscs
  hi('@comment',     { link='Comment' })
  hi('@punctuation', { link='Delimiter' })

  -- - Constants
  hi('@constant',          { link='Constant' })
  hi('@constant.builtin',  { link='Special' })
  hi('@constant.macro',    { link='Define' })
  hi('@define',            { link='Define' })
  hi('@macro',             { link='Macro' })
  hi('@string',            { link='String' })
  hi('@string.escape',     { link='SpecialChar' })
  hi('@string.special',    { link='SpecialChar' })
  hi('@character',         { link='Character' })
  hi('@character.special', { link='SpecialChar' })
  hi('@number',            { link='Number' })
  hi('@boolean',           { link='Boolean' })
  hi('@float',             { link='Float' })

  -- - Functions
  hi('@function',         { link='Function' })
  hi('@function.builtin', { link='Special' })
  hi('@function.macro',   { link='Macro' })
  hi('@parameter',        { link='Identifier' })
  hi('@method',           { link='Function' })
  hi('@field',            { link='Identifier' })
  hi('@property',         { link='Identifier' })
  hi('@constructor',      { link='Special' })

  -- - Keywords
  hi('@conditional', { link='Conditional' })
  hi('@repeat',      { link='Repeat' })
  hi('@label',       { link='Label' })
  hi('@operator',    { link='Operator' })
  hi('@keyword',     { link='Keyword' })
  hi('@exception',   { link='Exception' })

  hi('@variable',        { fg=nil, bg=nil }) -- using default foreground reduces visual overload
  hi('@type',            { link='Type' })
  hi('@type.definition', { link='Typedef' })
  hi('@storageclass',    { link='StorageClass' })
  hi('@namespace',       { link='Identifier' })
  hi('@include',         { link='Include' })
  hi('@preproc',         { link='PreProc' })
  hi('@debug',           { link='Debug' })
  hi('@tag',             { link='Tag' })

  -- - LSP semantic tokens
  hi('@lsp.type.class',         { link='Structure' })
  hi('@lsp.type.comment',       { link='Comment' })
  hi('@lsp.type.decorator',     { link='Function' })
  hi('@lsp.type.enum',          { link='Structure' })
  hi('@lsp.type.enumMember',    { link='Constant' })
  hi('@lsp.type.function',      { link='Function' })
  hi('@lsp.type.interface',     { link='Structure' })
  hi('@lsp.type.macro',         { link='Macro' })
  hi('@lsp.type.method',        { link='Function' })
  hi('@lsp.type.namespace',     { link='Structure' })
  hi('@lsp.type.parameter',     { link='Identifier' })
  hi('@lsp.type.property',      { link='Identifier' })
  hi('@lsp.type.struct',        { link='Structure' })
  hi('@lsp.type.type',          { link='Type' })
  hi('@lsp.type.typeParameter', { link='TypeDef' })
  hi('@lsp.type.variable',      { link='@variable' }) -- links to tree-sitter group to reduce overload

  -- Terminal colors (not ideal)
  vim.g.terminal_color_0  = bg.grey2
  vim.g.terminal_color_1  = fg.red
  vim.g.terminal_color_2  = fg.green
  vim.g.terminal_color_3  = fg.yellow
  vim.g.terminal_color_4  = fg.blue
  vim.g.terminal_color_5  = fg.magenta
  vim.g.terminal_color_6  = fg.cyan
  vim.g.terminal_color_7  = fg.grey2
  vim.g.terminal_color_8  = bg.grey2
  vim.g.terminal_color_9  = fg.red
  vim.g.terminal_color_10 = fg.green
  vim.g.terminal_color_11 = fg.yellow
  vim.g.terminal_color_12 = fg.blue
  vim.g.terminal_color_13 = fg.magenta
  vim.g.terminal_color_14 = fg.cyan
  vim.g.terminal_color_15 = fg.grey2
  --stylua: ignore end
end

-- Comment this to not enable color scheme
if apply_colorscheme then
  enable_colorscheme()
end
