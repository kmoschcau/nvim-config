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
local L = { 2, 6, 13, 20, 35, 50 }

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
local palette = {
  grey1   = convert(100 - L[1],       C.grey,  SH.neutral),
  grey2   = convert(100 - L[2],       C.grey,  SH.neutral),
  grey3   = convert(100 - L[3],       C.grey,  SH.neutral),
  grey4   = convert(100 - L[4],       C.grey,  SH.neutral),

  red     = convert(100 - L[2],       C.dark,  H.red),
  yellow  = convert(100 - L[2],       C.dark,  H.yellow),
  green   = convert(100 - L[2],       C.dark,  H.green),
  cyan    = convert(100 - L[5],       C.dark,  H.cyan),
  blue    = convert(100 - L[2],       C.dark,  H.blue),
  magenta = convert(100 - L[2],       C.dark,  H.magenta),

  interact = convert(70, 100, SH.interact),
}

local function invert_l(val)
  return colors.modify_channel(val, "lightness", function(l)
    return 100 - l
  end, { gamut_clip = "chroma" })
end

local palette_dark = vim.tbl_map(invert_l, palette)

-- Data {{{1

--- @class HighlightData
--- @field spec vim.api.keyset.highlight
--- @field contrast? number

--- @type table<string, vim.api.keyset.highlight>
local highlights_light = {
  Cursor = { bg = palette.interact },
  Normal = { fg = palette_dark.grey1, bg = palette.grey1 },
}

--- @param highlight vim.api.keyset.highlight
local function invert_hl(highlight)
  return vim.tbl_extend("force", highlight, {
    fg = highlight.fg and invert_l(highlight.fg) or nil,
    bg = highlight.bg and invert_l(highlight.bg) or nil,
  })
end

--stylua: ignore
local highlights_dark_overrides = {
}

--- @type table<string, vim.api.keyset.highlight>
local highlights_dark = vim.tbl_extend(
  "force",
  vim.tbl_map(invert_hl, highlights_light),
  highlights_dark_overrides
)

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

local data_light = map_specs(highlights_light)
local data_dark = map_specs(highlights_dark)

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

add_contrast_ratios(data_light)
add_contrast_ratios(data_dark)

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
  vim.list_extend(lines, { "Light:" })
  create_preview_lines(lines, data_light)
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "Dark:" })
  create_preview_lines(lines, data_dark)
  vim.list_extend(lines, { "", "" })

  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  highlight_preview_lines(
    buf_id,
    ext_ns,
    3,
    highlights_light,
    highlights_light.Normal,
    "light"
  )
  highlight_preview_lines(
    buf_id,
    ext_ns,
    3 + #highlights_light + 4,
    highlights_dark,
    highlights_dark.Normal,
    "dark"
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
  local bg = is_dark and palette_dark or palette
  local fg = is_dark and palette or palette_dark
  local hls = is_dark and highlights_dark or highlights_light

  -- Source for actual groups: 'src/nvim/highlight_group.c' in Neovim source code
  local function hi(name, data)
    vim.api.nvim_set_hl(0, name, data)
  end

  for key, value in pairs(hls) do
    hi(key, value)
  end

  --stylua: ignore start
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
