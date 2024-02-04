-- vim: foldmethod=marker

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

local hues = {
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
--- These are not just hue constants, but associations of semantic objects to
--- hues.
local H = {
  neutral = hues.grey,
  interact = hues.cyan,
  insert = hues.blue,
  replace = hues.amber,
  modified = hues.purple,
  search = hues.yellow,
  messages = hues.green,
  diff = {
    add = hues.green,
    change = hues.orange,
    delete = hues.red,
    text = hues.amber,
  },
  diagnostics = {
    error = hues.red,
    warn = hues.orange,
  },
  spell = {
    bad = hues.red,
    cap = hues.yellow,
    loc = hues.green,
    rare = hues.cyan,
  },
  syntax = {
    boolean   = hues.orange,
    character = hues.green - 20,
    directory = hues.blue,
    float     = hues.blue + 20,
    namespace = hues.brown,
    number    = hues.blue,
    string    = hues.green,
  },
}

-- Palettes {{{1

local function convert(l, c, h, opts)
  return colors.convert({ l = l, c = c, h = h }, "hex", {
    gamut_clip = opts and opts.gamut_clip or "chroma",
  })
end

local function make_syn(hue)
  return convert(60, 100, hue)
end

local function make_syn_with_bg(hue)
  return {
    fg = convert(50, 100, hue),
    bg = convert(95, 5, hue),
  }
end

--stylua: ignore
local palette = {
  neutral = {
    max            = convert(100,   0, H.neutral),
    lightest       = convert( 97,   0, H.neutral),
    lighter_still  = convert( 95,   0, H.neutral),
    lighter        = convert( 92,   0, H.neutral),
    light          = convert( 80,   0, H.neutral),
    half_light     = convert( 75,   0, H.neutral),
    mid_light      = convert( 60,   0, H.neutral),
    mid            = convert( 50,   0, H.neutral),
    mid_strong     = convert( 40,   0, H.neutral),
    half_strong    = convert( 25,   0, H.neutral),
    strong         = convert( 20,   0, H.neutral),
    stronger       = convert(  8,   0, H.neutral),
    stronger_still = convert(  5,   0, H.neutral),
    strongest      = convert(  3,   0, H.neutral),
    min            = convert(  0,   0, H.neutral),
  },

  interact = {
    cursor = {
      normal      = convert(70, 100, H.interact),
      non_current = convert(90,   7, H.interact),
      markers     = convert(90,   4, H.interact),
      visual      = convert(90,  10, H.interact),
    },
    statusline = {
      current = convert(70, 100, H.interact),
    },
  },

  search = {
    inc     = convert(85, 100, H.search),
    current = convert(90,   7, H.search),
    search  = convert(90,  10, H.search),
  },

  diff = {
    add = {
      light = convert(90,   5, H.diff.add),
    },
    change = {
      light = convert(89,  10, H.diff.change),
    },
    delete = {
      light = convert(85,  10, H.diff.delete),
    },
    text = {
      light = convert(85,  10, H.diff.text),
    },
  },

  diagnostics = {
    error = convert(40, 100, H.diagnostics.error),
    warn  = convert(40, 100, H.diagnostics.warn),
  },

  spell = {
    bad  = convert(50, 100, H.spell.bad),
    cap  = convert(70, 100, H.spell.cap),
    loc  = convert(70, 100, H.spell.loc),
    rare = convert(70, 100, H.spell.rare),
  },

  messages = {
    mode     = convert(30, 100, H.messages),
    more     = convert(50, 100, H.messages),
    question = convert(50, 100, H.messages),
  },

  syntax = {
    boolean   = make_syn_with_bg(H.syntax.boolean),
    character = make_syn_with_bg(H.syntax.character),
    comment   = convert(60,   0, H.neutral),
    directory = make_syn(H.syntax.directory),
    float     = make_syn_with_bg(H.syntax.float),
    number    = make_syn_with_bg(H.syntax.number),
    string    = make_syn_with_bg(H.syntax.string),
  },

  terminal_colors_light = {
    "#424242",
    "#f44336",
    "#8bc34a",
    "#ff9800",
    "#2196f3",
    "#9c27b0",
    "#009688",
    "#eeeeee",
    "#212121",
    "#d32f2f",
    "#689f38",
    "#f57c00",
    "#1976d2",
    "#7b1fa2",
    "#00796b",
    "#e0e0e0",
  },

  terminal_colors_dark = {
    "#f5f5f5",
    "#ef5350",
    "#9ccc65",
    "#ffa726",
    "#42a5f5",
    "#ab47bc",
    "#26a69a",
    "#616161",
    "#fafafa",
    "#ef9a9a",
    "#c5e1a5",
    "#ffcc80",
    "#90caf9",
    "#ce93d8",
    "#80cbc4",
    "#757575",
  },
}

-- Highlights {{{1

local status_col_fg = palette.neutral.mid_strong
local status_col_bg = palette.neutral.half_light

local function modify_l(val, L)
  return colors.modify_channel(val, "lightness", function(l)
    return l + L
  end, { gamut_clip = "lightness" })
end

--stylua: ignore start

--- @type table<string, vim.api.keyset.highlight>
local highlights_light = {
  -- built-in *highlight-groups* {{{2
  ColorColumn   = {                                         bg = palette.neutral.lighter_still },
  Conceal       = { fg = palette.neutral.mid_strong         },
  CurSearch     = {                                         bg = palette.search.current },
  Cursor        = {                                         bg = palette.interact.cursor.normal },
  lCursor       = { link = "Cursor" },
  CursorColumn  = {                                         bg = palette.interact.cursor.markers },
  CursorLine    = {                                         bg = palette.interact.cursor.markers },
  Directory     = { fg = palette.syntax.directory,                                                    bold = true },
  DiffAdd       = {                                         bg = palette.diff.add.light },
  DiffChange    = {                                         bg = palette.diff.change.light },
  DiffDelete    = {                                         bg = palette.diff.delete.light },
  DiffText      = {                                         bg = palette.diff.text.light,             bold = true },
  TermCursor    = { link = "Cursor" },
  TermCursorNC  = {                                         bg = palette.interact.cursor.non_current },
  ErrorMsg      = { fg = palette.diagnostics.error },
  WinSeparator  = { fg = palette.neutral.mid_strong,        bg = palette.neutral.mid_strong },
  Folded        = { fg = palette.neutral.mid_light,         bg = palette.neutral.lighter },
  SignColumn    = { fg = status_col_fg,                     bg = status_col_bg },
  IncSearch     = {                                         bg = palette.search.inc },
  LineNr        = { fg = status_col_fg,                     bg = status_col_bg },
  LineNrAbove   = { fg = modify_l(status_col_fg, 5),        bg = modify_l(status_col_bg, 5) },
  LineNrBelow   = { fg = modify_l(status_col_fg, -5),       bg = modify_l(status_col_bg, -5) },
  CursorLineNr  = { fg = status_col_fg,                     bg = palette.interact.cursor.markers },
  MatchParen    = {                                         bg = palette.interact.cursor.markers },
  ModeMsg       = { fg = palette.messages.mode },
  MsgSeparator  = {                                         bg = palette.neutral.mid_strong },
  MoreMsg       = { fg = palette.messages.more },
  NonText       = { fg = palette.neutral.light },
  Normal        = { fg = palette.neutral.strongest,         bg = palette.neutral.lightest },
  NormalFloat   = {                                         bg = palette.neutral.max },
  Pmenu         = {                                         bg = palette.neutral.max },
  PmenuSel      = {                                         bg = palette.interact.cursor.markers },
  PmenuKindSel  = { link = "Pmenu" },
  PmenuExtraSel = { link = "Pmenu" },
  PmenuSbar     = {                                         bg = palette.neutral.lighter_still },
  PmenuThumb    = {                                         bg = palette.neutral.mid },
  Question      = { fg = palette.messages.more },
  QuickFixLine  = {                                         bg = palette.interact.cursor.markers },
  Search        = {                                         bg = palette.search.search },
  SpecialKey    = { fg = palette.neutral.strong,            bg = palette.neutral.lighter,             italic = true },
  SpellBad      = {                                                                                   undercurl = true, sp = palette.spell.bad },
  SpellCap      = {                                                                                   undercurl = true, sp = palette.spell.cap },
  SpellLocal    = {                                                                                   undercurl = true, sp = palette.spell.loc },
  SpellRare     = {                                                                                   undercurl = true, sp = palette.spell.rare },
  StatusLine    = { fg = palette.neutral.lightest,          bg = palette.interact.statusline.current, bold = true },
  StatusLineNC  = { fg = palette.neutral.lightest,          bg = palette.neutral.mid_strong },
  TabLine       = { fg = palette.neutral.lightest,          bg = palette.neutral.half_light },
  TabLineFill   = {                                         bg = palette.neutral.mid_strong },
  TabLineSel    = { link = "Normal" },
  Title         = {                                                                                   bold = true },
  Visual        = {                                         bg = palette.interact.cursor.visual },
  WarningMsg    = { fg = palette.diagnostics.warn },
  WinBar        = { link = "StatusLine" },
  WinBarNC      = { link = "StatusLineNC" },

  -- syntax groups *group-name* {{{2
  Comment       = { fg = palette.syntax.comment },

  String        = { fg = palette.syntax.string.fg,          bg = palette.syntax.string.bg },
  Character     = { fg = palette.syntax.character.fg,       bg = palette.syntax.character.bg },
  Number        = { fg = palette.syntax.number.fg,          bg = palette.syntax.number.bg },
  Boolean       = { fg = palette.syntax.boolean.fg,         bg = palette.syntax.boolean.bg },
  Float         = { fg = palette.syntax.float.fg,           bg = palette.syntax.float.bg },
}
--stylua: ignore end

--- @param highlight vim.api.keyset.highlight
local function invert_highlight(highlight)
  local function invert_l(val)
    return colors.modify_channel(val, "lightness", function(l)
      return 100 - l
    end, { gamut_clip = "lightness" })
  end

  return vim.tbl_extend("force", highlight, {
    fg = highlight.fg and invert_l(highlight.fg) or nil,
    bg = highlight.bg and invert_l(highlight.bg) or nil,
  })
end

--stylua: ignore start

--- @type table<string, vim.api.keyset.highlight>
local highlights_dark_overrides = {
}
--stylua: ignore end

--- @type table<string, vim.api.keyset.highlight>
local highlights_dark = vim.tbl_extend(
  "force",
  vim.tbl_map(invert_highlight, highlights_light),
  highlights_dark_overrides
)

--- @param highlights table<string, vim.api.keyset.highlight>
local function add_cterm_values(highlights)
  for _, value in pairs(highlights) do
    if value.fg then
      value.ctermfg = require("mini.colors").convert(value.fg, "8-bit")
    end
    if value.bg then
      value.ctermbg = require("mini.colors").convert(value.bg, "8-bit")
    end
  end
end

add_cterm_values(highlights_light)
add_cterm_values(highlights_dark)

-- Contrast ratios {{{1

-- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef
---@param fg string
---@param bg string
---@return number
local function get_contrast_ratio(fg, bg)
  -- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
  local function get_luminance(hex)
    local rgb = colors.convert(hex, "rgb") --[[@as table]]

    -- Convert decimal color to [0; 1]
    local r, g, b = rgb.r / 255, rgb.g / 255, rgb.b / 255

    -- Correct channels
    local function correct_channel(x)
      return x <= 0.04045 and (x / 12.92) or math.pow((x + 0.055) / 1.055, 2.4)
    end
    local R, G, B = correct_channel(r), correct_channel(g), correct_channel(b)

    return 0.2126 * R + 0.7152 * G + 0.0722 * B
  end

  local lum_fg, lum_bg = get_luminance(fg), get_luminance(bg)
  local res = (math.max(lum_bg, lum_fg) + 0.05)
    / (math.min(lum_bg, lum_fg) + 0.05)
  return math.floor(10 * res + 0.5) / 10
end

--- @param highlight vim.api.keyset.highlight
--- @param normal vim.api.keyset.highlight
--- @return number
local function get_highlight_contrast_ratio(highlight, normal)
  return get_contrast_ratio(
    highlight.fg or normal.fg,
    highlight.bg or normal.bg
  )
end

-- Preview buffer {{{1

local function insert_highlight_preview_header(lines)
  table.insert(
    lines,
    string.format(
      "%4s %-20s %-8s %7s %7s %7s %7s %7s %5s %s",
      "Demo",
      "Name",
      "Contrast",
      "fg",
      "bg",
      "special",
      "ctermfg",
      "ctermbg",
      "blend",
      "attrs"
    )
  )
end

--- @param hls table<string, vim.api.keyset.highlight>
local function insert_highlight_preview_lines(lines, hls)
  local keys = vim.tbl_keys(hls)
  table.sort(keys)

  local bool_keys = {
    "bold",
    "standout",
    "strikethrough",
    "underline",
    "undercurl",
    "underdouble",
    "underdotted",
    "underdashed",
    "italic",
    "reverse",
    "altfont",
    "nocombine",
    "default",
    "fallback",
    "fg_indexed",
    "bg_indexed",
    "force",
  }

  for _, key in ipairs(keys) do
    local hl = hls[key]

    if hl.link then
      table.insert(lines, string.format("XXX  %-20s -> %s", key, hl.link))
    else
      table.insert(lines, (string
        .format(
          "XXX  %-20s %8.1f %7s %7s %7s %7s %7s %5d %s",
          key,
          get_highlight_contrast_ratio(hl, hls.Normal),
          hl.fg or "",
          hl.bg or "",
          hl.special or "",
          hl.ctermfg or "",
          hl.ctermbg or "",
          hl.blend or 0,
          table.concat(
            vim.tbl_filter(
              function(k)
                return k
              end,
              vim.tbl_map(function(k)
                return hl[k] and k or nil
              end, bool_keys)
            ),
            ","
          )
        )
        :gsub("%s+$", "")))
    end
  end
end

--- @param clrs string[]
--- @param bg string
local function insert_terminal_colors_preview_lines(lines, clrs, bg)
  for index, value in ipairs(clrs) do
    table.insert(
      lines,
      string.format(
        "XXX %2d %4.1f %7s",
        index - 1,
        get_contrast_ratio(value, bg),
        value
      )
    )
  end
end

--- @param name string
--- @param spec vim.api.keyset.highlight
--- @param ext_ns number
--- @param line_index number
local function color_preview(name, spec, ext_ns, line_index)
  vim.api.nvim_set_hl(0, name, spec)
  vim.api.nvim_buf_add_highlight(0, ext_ns, name, line_index, 0, 3)
end

--- @param normal vim.api.keyset.highlight
--- @param diagnostics vim.Diagnostic[]
local function color_highlight_preview_lines(
  ext_ns,
  start_after_line,
  hls,
  diagnostics,
  normal,
  suffix
)
  local keys = vim.tbl_keys(hls)
  table.sort(keys)

  for index, key in ipairs(keys) do
    local name = key .. "_preview_" .. suffix
    local hl = hls[key]
    local line_index = start_after_line + index

    local spec
    if hl.link then
      spec = vim.tbl_extend("keep", hls[hl.link], normal)
    else
      spec = vim.tbl_extend("keep", hl, normal)
    end
    color_preview(name, spec, ext_ns, line_index)

    local contrast = get_highlight_contrast_ratio(hl, normal)
    if contrast < 7 then
      table.insert(
        diagnostics,
        {
          lnum = line_index,
          col = 31,
          end_col = 34,
          severity = vim.diagnostic.severity.W,
          message = "Contrast is below 7.",
          source = "color-tool",
          code = "below-7",
        }
      )
    end
  end
end

--- @param normal vim.api.keyset.highlight
local function color_terminal_preview_lines(
  ext_ns,
  start_after_line,
  clrs,
  normal,
  suffix
)
  for index, value in ipairs(clrs) do
    local name = "terminal_color_" .. index - 1 .. "_" .. suffix

    local spec = { fg = value, bg = normal.bg }

    color_preview(name, spec, ext_ns, index + start_after_line)
  end
end

local function create_preview_buffer()
  local ext_ns = vim.api.nvim_create_namespace "highlight-previews-extmarks"
  local diag_ns = vim.api.nvim_create_namespace "highlight-previews-diagnostics"

  --- @type string[]
  local lines = {}

  vim.list_extend(lines, { "--- Highlights ---" })
  insert_highlight_preview_header(lines)
  vim.list_extend(lines, { "Light:" })
  insert_highlight_preview_lines(lines, highlights_light)
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "Dark:" })
  insert_highlight_preview_lines(lines, highlights_dark)
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "--- Terminal colors ---" })
  vim.list_extend(lines, { "Light:" })
  insert_terminal_colors_preview_lines(
    lines,
    palette.terminal_colors_light,
    highlights_light.Normal.bg
  )
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "Dark:" })
  insert_terminal_colors_preview_lines(
    lines,
    palette.terminal_colors_dark,
    highlights_dark.Normal.bg
  )

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  --- @type vim.Diagnostic[]
  local diagnostics = {}

  local start_after_line = 2
  color_highlight_preview_lines(
    ext_ns,
    start_after_line,
    highlights_light,
    diagnostics,
    highlights_light.Normal,
    "light"
  )

  start_after_line = start_after_line + vim.tbl_count(highlights_light) + 2
  color_highlight_preview_lines(
    ext_ns,
    start_after_line,
    highlights_dark,
    diagnostics,
    highlights_dark.Normal,
    "dark"
  )

  start_after_line = start_after_line + vim.tbl_count(highlights_dark) + 3
  color_terminal_preview_lines(
    ext_ns,
    start_after_line,
    palette.terminal_colors_light,
    highlights_light.Normal,
    "light"
  )

  start_after_line = start_after_line
    + vim.tbl_count(palette.terminal_colors_light)
    + 2
  color_terminal_preview_lines(
    ext_ns,
    start_after_line,
    palette.terminal_colors_dark,
    highlights_dark.Normal,
    "dark"
  )

  vim.diagnostic.set(diag_ns, 0, diagnostics)
end

if show_preview_buffer then
  create_preview_buffer()
end

-- Highlight groups {{{1

local function enable_colorscheme()
  vim.cmd.highlight "clear"
  vim.g.colors_name = "new_colors"

  local is_dark = vim.o.background == "dark"
  local hls = is_dark and highlights_dark or highlights_light
  local tcs = is_dark and palette.terminal_colors_dark
    or palette.terminal_colors_light

  local function hi(name, data)
    vim.api.nvim_set_hl(0, name, data)
  end

  for key, value in pairs(hls) do
    hi(key, value)
  end

  for index, value in ipairs(tcs) do
    vim.g["terminal_color_" .. index + 1] = value
  end
end

-- Comment this to not enable color scheme
if apply_colorscheme then
  enable_colorscheme()
end
