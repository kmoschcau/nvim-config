-- vim: foldmethod=marker
-- -----------------------------------------------------------------------------
-- File:          material.vim
-- Description:   A configurable material based theme
-- Author:        Kai Moschcau <mail@kmoschcau.de>
-- -----------------------------------------------------------------------------

-- General setup {{{1

-- Reset all highlight groups to the default.
vim.cmd [[highlight clear]]

-- Set the name of the colortheme.
vim.g.colors_name = vim.fn.expand "<sfile>:t:r"

-- Material color palette {{{2

local material = {
  red = {
    [50] = { gui = "#ffebee", cterm = 255 },
    [100] = { gui = "#ffcdd2", cterm = 224 },
    [200] = { gui = "#ef9a9a", cterm = 210 },
    [300] = { gui = "#e57373", cterm = 174 },
    [400] = { gui = "#ef5350", cterm = 203 },
    [500] = { gui = "#f44336", cterm = 203 },
    [600] = { gui = "#e53935", cterm = 167 },
    [700] = { gui = "#d32f2f", cterm = 160 },
    [800] = { gui = "#c62828", cterm = 160 },
    [900] = { gui = "#b71c1c", cterm = 124 },
    A100 = { gui = "#ff8a80", cterm = 210 },
    A200 = { gui = "#ff5252", cterm = 203 },
    A400 = { gui = "#ff1744", cterm = 197 },
    A700 = { gui = "#d50000", cterm = 160 },
  },
  pink = {
    [50] = { gui = "#fce4ec", cterm = 255 },
    [100] = { gui = "#f8bbd0", cterm = 218 },
    [200] = { gui = "#f48fb1", cterm = 211 },
    [300] = { gui = "#f06292", cterm = 204 },
    [400] = { gui = "#ec407a", cterm = 204 },
    [500] = { gui = "#e91e63", cterm = 161 },
    [600] = { gui = "#d81b60", cterm = 161 },
    [700] = { gui = "#c2185b", cterm = 125 },
    [800] = { gui = "#ad1457", cterm = 125 },
    [900] = { gui = "#880e4f", cterm = 89 },
    A100 = { gui = "#ff80ab", cterm = 211 },
    A200 = { gui = "#ff4081", cterm = 204 },
    A400 = { gui = "#f50057", cterm = 197 },
    A700 = { gui = "#c51162", cterm = 161 },
  },
  purple = {
    [50] = { gui = "#f3e5f5", cterm = 255 },
    [100] = { gui = "#e1bee7", cterm = 182 },
    [200] = { gui = "#ce93d8", cterm = 176 },
    [300] = { gui = "#ba68c8", cterm = 134 },
    [400] = { gui = "#ab47bc", cterm = 133 },
    [500] = { gui = "#9c27b0", cterm = 127 },
    [600] = { gui = "#8e24aa", cterm = 91 },
    [700] = { gui = "#7b1fa2", cterm = 91 },
    [800] = { gui = "#6a1b9a", cterm = 54 },
    [900] = { gui = "#4a148c", cterm = 54 },
    A100 = { gui = "#ea80fc", cterm = 177 },
    A200 = { gui = "#e040fb", cterm = 171 },
    A400 = { gui = "#d500f9", cterm = 165 },
    A700 = { gui = "#aa00ff", cterm = 129 },
  },
  deep_purple = {
    [50] = { gui = "#ede7f6", cterm = 255 },
    [100] = { gui = "#d1c4e9", cterm = 188 },
    [200] = { gui = "#b39ddb", cterm = 146 },
    [300] = { gui = "#9575cd", cterm = 104 },
    [400] = { gui = "#7e57c2", cterm = 97 },
    [500] = { gui = "#673ab7", cterm = 61 },
    [600] = { gui = "#5e35b1", cterm = 61 },
    [700] = { gui = "#512da8", cterm = 55 },
    [800] = { gui = "#4527a0", cterm = 55 },
    [900] = { gui = "#311b92", cterm = 54 },
    A100 = { gui = "#b388ff", cterm = 141 },
    A200 = { gui = "#7c4dff", cterm = 99 },
    A400 = { gui = "#651fff", cterm = 57 },
    A700 = { gui = "#6200ea", cterm = 56 },
  },
  indigo = {
    [50] = { gui = "#e8eaf6", cterm = 255 },
    [100] = { gui = "#c5cae9", cterm = 252 },
    [200] = { gui = "#9fa8da", cterm = 146 },
    [300] = { gui = "#7986cb", cterm = 104 },
    [400] = { gui = "#5c6bc0", cterm = 61 },
    [500] = { gui = "#3f51b5", cterm = 61 },
    [600] = { gui = "#3949ab", cterm = 61 },
    [700] = { gui = "#303f9f", cterm = 61 },
    [800] = { gui = "#283593", cterm = 24 },
    [900] = { gui = "#1a237e", cterm = 18 },
    A100 = { gui = "#8c9eff", cterm = 111 },
    A200 = { gui = "#536dfe", cterm = 63 },
    A400 = { gui = "#3d5afe", cterm = 63 },
    A700 = { gui = "#304ffe", cterm = 63 },
  },
  blue = {
    [50] = { gui = "#e3f2fd", cterm = 195 },
    [100] = { gui = "#bbdefb", cterm = 153 },
    [200] = { gui = "#90caf9", cterm = 117 },
    [300] = { gui = "#64b5f6", cterm = 75 },
    [400] = { gui = "#42a5f5", cterm = 75 },
    [500] = { gui = "#2196f3", cterm = 33 },
    [600] = { gui = "#1e88e5", cterm = 32 },
    [700] = { gui = "#1976d2", cterm = 32 },
    [800] = { gui = "#1565c0", cterm = 25 },
    [900] = { gui = "#0d47a1", cterm = 25 },
    A100 = { gui = "#82b1ff", cterm = 111 },
    A200 = { gui = "#448aff", cterm = 69 },
    A400 = { gui = "#2979ff", cterm = 33 },
    A700 = { gui = "#2962ff", cterm = 27 },
  },
  light_blue = {
    [50] = { gui = "#e1f5fe", cterm = 195 },
    [100] = { gui = "#b3e5fc", cterm = 153 },
    [200] = { gui = "#81d4fa", cterm = 117 },
    [300] = { gui = "#4fc3f7", cterm = 81 },
    [400] = { gui = "#29b6f6", cterm = 39 },
    [500] = { gui = "#03a9f4", cterm = 39 },
    [600] = { gui = "#039be5", cterm = 38 },
    [700] = { gui = "#0288d1", cterm = 32 },
    [800] = { gui = "#0277bd", cterm = 31 },
    [900] = { gui = "#01579b", cterm = 25 },
    A100 = { gui = "#80d8ff", cterm = 117 },
    A200 = { gui = "#40c4ff", cterm = 81 },
    A400 = { gui = "#00b0ff", cterm = 39 },
    A700 = { gui = "#0091ea", cterm = 32 },
  },
  cyan = {
    [50] = { gui = "#e0f7fa", cterm = 195 },
    [100] = { gui = "#b2ebf2", cterm = 159 },
    [200] = { gui = "#80deea", cterm = 116 },
    [300] = { gui = "#4dd0e1", cterm = 80 },
    [400] = { gui = "#26c6da", cterm = 44 },
    [500] = { gui = "#00bcd4", cterm = 38 },
    [600] = { gui = "#00acc1", cterm = 37 },
    [700] = { gui = "#0097a7", cterm = 31 },
    [800] = { gui = "#00838f", cterm = 30 },
    [900] = { gui = "#006064", cterm = 23 },
    A100 = { gui = "#84ffff", cterm = 123 },
    A200 = { gui = "#18ffff", cterm = 51 },
    A400 = { gui = "#00e5ff", cterm = 45 },
    A700 = { gui = "#00b8d4", cterm = 38 },
  },
  teal = {
    [50] = { gui = "#e0f2f1", cterm = 255 },
    [100] = { gui = "#b2dfdb", cterm = 152 },
    [200] = { gui = "#80cbc4", cterm = 116 },
    [300] = { gui = "#4db6ac", cterm = 73 },
    [400] = { gui = "#26a69a", cterm = 36 },
    [500] = { gui = "#009688", cterm = 30 },
    [600] = { gui = "#00897b", cterm = 30 },
    [700] = { gui = "#00796b", cterm = 29 },
    [800] = { gui = "#00695c", cterm = 23 },
    [900] = { gui = "#004d40", cterm = 23 },
    A100 = { gui = "#a7ffeb", cterm = 159 },
    A200 = { gui = "#64ffda", cterm = 86 },
    A400 = { gui = "#1de9b6", cterm = 43 },
    A700 = { gui = "#00bfa5", cterm = 37 },
  },
  green = {
    [50] = { gui = "#e8f5e9", cterm = 255 },
    [100] = { gui = "#c8e6c9", cterm = 252 },
    [200] = { gui = "#a5d6a7", cterm = 151 },
    [300] = { gui = "#81c784", cterm = 114 },
    [400] = { gui = "#66bb6a", cterm = 71 },
    [500] = { gui = "#4caf50", cterm = 71 },
    [600] = { gui = "#43a047", cterm = 71 },
    [700] = { gui = "#388e3c", cterm = 65 },
    [800] = { gui = "#2e7d32", cterm = 239 },
    [900] = { gui = "#1b5e20", cterm = 22 },
    A100 = { gui = "#b9f6ca", cterm = 158 },
    A200 = { gui = "#69f0ae", cterm = 85 },
    A400 = { gui = "#00e676", cterm = 42 },
    A700 = { gui = "#00c853", cterm = 41 },
  },
  light_green = {
    [50] = { gui = "#f1f8e9", cterm = 255 },
    [100] = { gui = "#dcedc8", cterm = 194 },
    [200] = { gui = "#c5e1a5", cterm = 187 },
    [300] = { gui = "#aed581", cterm = 150 },
    [400] = { gui = "#9ccc65", cterm = 149 },
    [500] = { gui = "#8bc34a", cterm = 113 },
    [600] = { gui = "#7cb342", cterm = 107 },
    [700] = { gui = "#689f38", cterm = 71 },
    [800] = { gui = "#558b2f", cterm = 64 },
    [900] = { gui = "#33691e", cterm = 58 },
    A100 = { gui = "#ccff90", cterm = 192 },
    A200 = { gui = "#b2ff59", cterm = 155 },
    A400 = { gui = "#76ff03", cterm = 118 },
    A700 = { gui = "#64dd17", cterm = 76 },
  },
  lime = {
    [50] = { gui = "#f9fbe7", cterm = 230 },
    [100] = { gui = "#f0f4c3", cterm = 230 },
    [200] = { gui = "#e6ee9c", cterm = 193 },
    [300] = { gui = "#dce775", cterm = 186 },
    [400] = { gui = "#d4e157", cterm = 185 },
    [500] = { gui = "#cddc39", cterm = 185 },
    [600] = { gui = "#c0ca33", cterm = 149 },
    [700] = { gui = "#afb42b", cterm = 142 },
    [800] = { gui = "#9e9d24", cterm = 142 },
    [900] = { gui = "#827717", cterm = 100 },
    A100 = { gui = "#f4ff81", cterm = 228 },
    A200 = { gui = "#eeff41", cterm = 227 },
    A400 = { gui = "#c6ff00", cterm = 190 },
    A700 = { gui = "#aeea00", cterm = 148 },
  },
  yellow = {
    [50] = { gui = "#fffde7", cterm = 230 },
    [100] = { gui = "#fff9c4", cterm = 230 },
    [200] = { gui = "#fff59d", cterm = 229 },
    [300] = { gui = "#fff176", cterm = 228 },
    [400] = { gui = "#ffee58", cterm = 227 },
    [500] = { gui = "#ffeb3b", cterm = 227 },
    [600] = { gui = "#fdd835", cterm = 221 },
    [700] = { gui = "#fbc02d", cterm = 214 },
    [800] = { gui = "#f9a825", cterm = 214 },
    [900] = { gui = "#f57f17", cterm = 208 },
    A100 = { gui = "#ffff8d", cterm = 228 },
    A200 = { gui = "#ffff00", cterm = 226 },
    A400 = { gui = "#ffea00", cterm = 220 },
    A700 = { gui = "#ffd600", cterm = 220 },
  },
  amber = {
    [50] = { gui = "#fff8e1", cterm = 230 },
    [100] = { gui = "#ffecb3", cterm = 229 },
    [200] = { gui = "#ffe082", cterm = 222 },
    [300] = { gui = "#ffd54f", cterm = 221 },
    [400] = { gui = "#ffca28", cterm = 220 },
    [500] = { gui = "#ffc107", cterm = 214 },
    [600] = { gui = "#ffb300", cterm = 214 },
    [700] = { gui = "#ffa000", cterm = 214 },
    [800] = { gui = "#ff8f00", cterm = 208 },
    [900] = { gui = "#ff6f00", cterm = 202 },
    A100 = { gui = "#ffe57f", cterm = 222 },
    A200 = { gui = "#ffd740", cterm = 221 },
    A400 = { gui = "#ffc400", cterm = 220 },
    A700 = { gui = "#ffab00", cterm = 214 },
  },
  orange = {
    [50] = { gui = "#fff3e0", cterm = 230 },
    [100] = { gui = "#ffe0b2", cterm = 223 },
    [200] = { gui = "#ffcc80", cterm = 222 },
    [300] = { gui = "#ffb74d", cterm = 215 },
    [400] = { gui = "#ffa726", cterm = 214 },
    [500] = { gui = "#ff9800", cterm = 208 },
    [600] = { gui = "#fb8c00", cterm = 208 },
    [700] = { gui = "#f57c00", cterm = 208 },
    [800] = { gui = "#ef6c00", cterm = 202 },
    [900] = { gui = "#e65100", cterm = 166 },
    A100 = { gui = "#ffd180", cterm = 222 },
    A200 = { gui = "#ffab40", cterm = 215 },
    A400 = { gui = "#ff9100", cterm = 208 },
    A700 = { gui = "#ff6d00", cterm = 202 },
  },
  deep_orange = {
    [50] = { gui = "#fbe9e7", cterm = 255 },
    [100] = { gui = "#ffccbc", cterm = 223 },
    [200] = { gui = "#ffab91", cterm = 216 },
    [300] = { gui = "#ff8a65", cterm = 209 },
    [400] = { gui = "#ff7043", cterm = 203 },
    [500] = { gui = "#ff5722", cterm = 202 },
    [600] = { gui = "#f4511e", cterm = 202 },
    [700] = { gui = "#e64a19", cterm = 166 },
    [800] = { gui = "#d84315", cterm = 166 },
    [900] = { gui = "#bf360c", cterm = 130 },
    A100 = { gui = "#ff9e80", cterm = 216 },
    A200 = { gui = "#ff6e40", cterm = 203 },
    A400 = { gui = "#ff3d00", cterm = 202 },
    A700 = { gui = "#dd2c00", cterm = 160 },
  },
  brown = {
    [50] = { gui = "#efebe9", cterm = 255 },
    [100] = { gui = "#d7ccc8", cterm = 252 },
    [200] = { gui = "#bcaaa4", cterm = 145 },
    [300] = { gui = "#a1887f", cterm = 138 },
    [400] = { gui = "#8d6e63", cterm = 95 },
    [500] = { gui = "#795548", cterm = 95 },
    [600] = { gui = "#6d4c41", cterm = 240 },
    [700] = { gui = "#5d4037", cterm = 238 },
    [800] = { gui = "#4e342e", cterm = 237 },
    [900] = { gui = "#3e2723", cterm = 236 },
  },
  grey = {
    [50] = { gui = "#fafafa", cterm = 231 },
    [100] = { gui = "#f5f5f5", cterm = 255 },
    [200] = { gui = "#eeeeee", cterm = 255 },
    [300] = { gui = "#e0e0e0", cterm = 254 },
    [400] = { gui = "#bdbdbd", cterm = 250 },
    [500] = { gui = "#9e9e9e", cterm = 247 },
    [600] = { gui = "#757575", cterm = 243 },
    [700] = { gui = "#616161", cterm = 241 },
    [800] = { gui = "#424242", cterm = 238 },
    [900] = { gui = "#212121", cterm = 235 },
  },
  blue_grey = {
    [50] = { gui = "#eceff1", cterm = 255 },
    [100] = { gui = "#cfd8dc", cterm = 188 },
    [200] = { gui = "#b0bec5", cterm = 250 },
    [300] = { gui = "#90a4ae", cterm = 109 },
    [400] = { gui = "#78909c", cterm = 103 },
    [500] = { gui = "#607d8b", cterm = 66 },
    [600] = { gui = "#546e7a", cterm = 60 },
    [700] = { gui = "#455a64", cterm = 240 },
    [800] = { gui = "#37474f", cterm = 238 },
    [900] = { gui = "#263238", cterm = 236 },
  },
  transparent = { gui = "NONE", cterm = "NONE" },
}

-- Default hue selection {{{2

-- Hue used for most of the editor background and framing, should be subtle.
local hue_neutral = "grey"

-- Hue used as the primary accent for currently interacted with elements in
-- normal mode
local hue_primary = "cyan"

-- Hue used for insert mode
local hue_insert = "blue"

-- Hue used for replace mode
local hue_replace = "amber"

-- Diff hues {{{3

-- Hue used for added diff
local hue_diff_added = "green"

-- Hue used for changed diff
local hue_diff_changed = "amber"

-- Hue used for deleted diff
local hue_diff_deleted = "red"

-- Hue used for text diff
local hue_diff_text = "orange"

-- Value list {{{2

local normal_values = { 50, 100, 200, 300, 400, 500, 600, 700, 800, 900 }

local accent_values = { "A100", "A200", "A400", "A700" }

-- Functions {{{2

-- Set the highlight group passed as group_name to the values specified in
-- config.
local function highlight(group_name, config)
  local def = {}

  if config.fg then
    def.fg = config.fg.gui
    def.ctermfg = config.fg.cterm
  end

  if config.bg then
    def.bg = config.bg.gui
    def.ctermbg = config.bg.cterm
  end

  if config.sp then
    def.sp = config.sp.gui
  end

  if vim.o.background == "dark" then
    if config.fg_dark then
      def.fg = config.fg_dark.gui
      def.ctermfg = config.fg_dark.cterm
    end

    if config.bg_dark then
      def.bg = config.bg_dark.gui
      def.ctermbg = config.bg_dark.cterm
    end

    if config.sp_dark then
      def.sp = config.sp_dark.gui
    end
  end

  for _, prop in ipairs {
    "blend",
    "bold",
    "standout",
    "underline",
    "undercurl",
    "underdouble",
    "underdotted",
    "underdashed",
    "strikethrough",
    "italic",
    "reverse",
    "nocombine",
    "link",
    "default",
  } do
    def[prop] = config[prop]
  end

  vim.api.nvim_set_hl(0, group_name, def)
end

-- Get the value number for the passed index, dependent on the 'background'.
local function value(index, invert_dark)
  local clamped = math.max(math.min(index, 10), 1)

  local value_index
  if invert_dark and vim.o.background == "dark" then
    value_index = #normal_values - clamped + 1
  else
    value_index = clamped
  end

  return normal_values[value_index]
end

-- Get the accent value string for the passed index, dependent on the
-- 'background'.
local function accent_value(index, invert_dark)
  local clamped = math.max(math.min(index, 4), 1)

  local value_index
  if invert_dark and vim.o.background == "dark" then
    value_index = #accent_values - clamped + 1
  else
    value_index = clamped
  end

  return accent_values[value_index]
end

-- Get a color table by the passed color name and the passed index, dependent on
-- the 'background'.
local function color_table(color_name, color_index, options)
  local accent = false
  local invert_dark = true
  if options then
    accent = options.accent or false
    invert_dark = options.invert_dark and true
  end

  if accent then
    local raw_accent_value = accent_value(color_index, invert_dark)
    local clamped_accent_value = vim
      .regex("brown|grey|blue_grey")
      :match_str(color_name) and raw_accent_value:sub(2) or raw_accent_value
    return material[color_name][clamped_accent_value]
  else
    return material[color_name][value(color_index, invert_dark)]
  end
end

-- Shared colors {{{2

-- Shared colors
local c = {
  neutral = {
    lightest = color_table(hue_neutral, 1),
    midpoint = color_table(hue_neutral, 5),
    midpoint_strong = color_table(hue_neutral, 6),
    strong = color_table(hue_neutral, 8),
  },
  interact = {
    light = color_table(hue_primary, 2),
  },
  error = {
    light = color_table("red", 3),
    strong = color_table("red", 6),
  },
  warning = {
    light = color_table("orange", 3),
    strong = color_table("orange", 6),
  },
  info = {
    light = color_table("light_blue", 3),
    strong = color_table("light_blue", 6),
  },
  debug = {
    light = color_table("grey", 3),
    strong = color_table("grey", 6),
  },
  trace = {
    light = color_table("purple", 3),
    strong = color_table("purple", 6),
  },
  syntax = {
    number = {
      light = color_table("blue", 1),
    },
    meta = {
      light = color_table("purple", 1),
      strong = color_table("purple", 4),
    },
    ["function"] = color_table("teal", 6),
    typedef = color_table("green", 6),
    structure = color_table("light_green", 6),
    type = color_table("lime", 6),
    namespace = color_table("brown", 4),
  },
}

-- Highlight definitions {{{2
-- Basics {{{3

-- This is somewhat of a hack and not like I intended it. But just linking the
-- Normal group to anything instead of defining it on its own will cause the
-- current window to have a transparent background for some reason.
vim.api.nvim_set_hl(0, "Material_VimNormal", { link = "Normal" })
highlight("Normal", { fg = c.neutral.strong, bg = c.neutral.lightest })
highlight("Material_VimNormalLight", { fg = c.neutral.midpoint })
highlight("Material_VimSpecialKey", {
  fg = c.neutral.strong,
  bg = color_table(hue_neutral, 3),
  italic = true,
})
highlight("Material_VimConceal", { fg = c.neutral.strong })

-- Popup menu and floating windows {{{3

highlight("Material_VimPopup", {
  fg = c.neutral.strong,
  bg = color_table(hue_neutral, 2),
})
highlight("Material_VimPopupSelected", { bg = c.interact.light })
highlight("Material_VimPopupScrollbar", { bg = c.neutral.midpoint })
highlight("Material_VimPopupThumb", { bg = color_table(hue_neutral, 10) })

-- Framing {{{3

highlight("Material_VimLighterFraming", { bg = color_table(hue_neutral, 2) })
highlight("Material_VimLightFramingSubtleFg", {
  fg = color_table(hue_neutral, 7),
  bg = c.neutral.midpoint,
})
highlight("Material_VimLightFramingStrongFg", {
  fg = c.neutral.lightest,
  bg = c.neutral.midpoint,
})
highlight("Material_VimStrongFramingWithoutFg", { bg = c.neutral.strong })
highlight("Material_VimStrongFramingWithFg", {
  fg = color_table(hue_neutral, 1, { accent = true }),
  bg = c.neutral.strong,
})
highlight("Material_VimStatusLine", {
  fg = c.neutral.lightest,
  bg = color_table(hue_primary, 4, { accent = true }),
  bold = true,
})
highlight("Material_VimStatusLineNC", {
  fg = c.neutral.lightest,
  bg = c.neutral.strong,
})

-- Cursor related {{{3

highlight("Material_VimVisual", { bg = c.interact.light })
highlight("Material_VimWildMenu", {
  fg = c.neutral.lightest,
  bg = color_table(hue_primary, 3),
  bold = true,
})
highlight("Material_VimCursorLines", { bg = c.interact.light })
highlight("Material_VimCursorLinesNum", {
  fg = c.neutral.midpoint_strong,
  bg = c.interact.light,
  bold = true,
})
highlight("Material_VimCursor", { bg = color_table(hue_primary, 6) })
highlight("Material_VimCursorInsert", { bg = color_table(hue_insert, 7) })
highlight("Material_VimCursorReplace", { bg = color_table(hue_replace, 7) })
highlight("Material_VimCursorUnfocused", { bg = color_table(hue_primary, 3) })

-- Diff related {{{3

highlight("Material_VimDiffAdd", { fg = color_table(hue_diff_added, 6) })
highlight("Material_VimDiffDelete", { fg = color_table(hue_diff_deleted, 6) })
highlight("Material_VimDiffLineAdd", {
  bg = color_table(hue_diff_added, 2),
  bg_dark = color_table(hue_diff_added, 10, { invert_dark = false }),
})
highlight("Material_VimDiffLineChange", {
  bg = color_table(hue_diff_changed, 2),
  bg_dark = color_table(hue_diff_changed, 10, { invert_dark = false }),
})
highlight("Material_VimDiffLineChangeDelete", {
  bg = color_table(hue_diff_changed, 3),
  bg_dark = color_table(hue_diff_changed, 9, { invert_dark = false }),
})
highlight("Material_VimDiffLineDelete", {
  bg = color_table(hue_diff_deleted, 2),
  bg_dark = color_table(hue_diff_deleted, 10, { invert_dark = false }),
})
highlight("Material_VimDiffLineText", {
  bg = color_table(hue_diff_text, 2),
  bg_dark = color_table(hue_diff_text, 10, { invert_dark = false }),
  bold = true,
})
highlight("Material_VimDiffSignAdd", {
  fg = c.neutral.lightest,
  bg = color_table(hue_diff_added, 6),
})
highlight("Material_VimDiffSignChange", {
  fg = c.neutral.lightest,
  bg = color_table(hue_diff_changed, 6),
})
highlight("Material_VimDiffSignChangeDelete", {
  fg = c.neutral.lightest,
  bg = color_table(hue_diff_changed, 7),
})
highlight("Material_VimDiffSignDelete", {
  fg = c.neutral.lightest,
  bg = color_table(hue_diff_deleted, 6),
})

-- Messages {{{3

highlight("Material_VimTitle", { fg = color_table("pink", 5), bold = true })
highlight("Material_VimModeMsg", { fg = c.neutral.strong, bold = true })
highlight("Material_VimMoreMsg", { fg = color_table("green", 8), bold = true })

highlight("Material_VimError", { fg = c.error.strong })
highlight("Material_VimErrorBorder", { fg = c.error.light })
highlight("Material_VimErrorInverted", {
  fg = c.neutral.lightest,
  bg = c.error.strong,
})
highlight("Material_VimErrorUnderline", {
  sp = c.error.strong,
  underline = true,
})

highlight("Material_VimStyleErrorInverted", {
  fg = c.neutral.lightest,
  bg = c.error.light,
})
highlight("Material_VimStyleErrorUnderline", {
  sp = c.error.light,
  undercurl = true,
})

highlight("Material_VimWarning", { fg = c.warning.strong })
highlight("Material_VimWarningBorder", { fg = c.warning.light })
highlight("Material_VimWarningInverted", {
  fg = c.neutral.lightest,
  bg = c.warning.strong,
})
highlight("Material_VimWarningUnderline", {
  sp = c.warning.strong,
  underline = true,
})

highlight("Material_VimStyleWarningInverted", {
  fg = c.neutral.lightest,
  bg = c.warning.light,
})
highlight("Material_VimStyleWarningUnderline", {
  sp = c.warning.light,
  undercurl = true,
})

highlight("Material_VimInfo", { fg = c.info.strong })
highlight("Material_VimInfoBorder", { fg = c.info.light })
highlight("Material_VimInfoInverted", {
  fg = c.neutral.lightest,
  bg = c.info.strong,
})
highlight("Material_VimInfoUnderline", {
  sp = c.info.strong,
  underline = true,
})

highlight("Material_VimDebug", { fg = c.debug.strong })
highlight("Material_VimDebugInverted", {
  fg = c.neutral.lightest,
  bg = c.debug.strong,
})
highlight("Material_VimDebugBorder", { fg = c.debug.light })

highlight("Material_VimTrace", { fg = c.trace.strong })
highlight("Material_VimTraceInverted", {
  fg = c.neutral.lightest,
  bg = c.trace.strong,
})
highlight("Material_VimTraceBorder", { fg = c.trace.light })

highlight("Material_VimHintInverted", {
  fg = c.neutral.lightest,
  bg = c.info.light,
})
highlight("Material_VimHintUnderline", { sp = c.info.light, underline = true })

-- Spelling {{{3

highlight("Material_VimSpellBad", { sp = c.error.strong, undercurl = true })
highlight("Material_VimSpellCap", {
  sp = color_table("indigo", 6),
  undercurl = true,
})
highlight("Material_VimSpellLocal", {
  sp = color_table("teal", 6),
  undercurl = true,
})
highlight("Material_VimSpellRare", {
  sp = color_table("pink", 4),
  undercurl = true,
})

-- Misc {{{3

highlight("Material_VimDirectory", { fg = color_table("blue", 5), bold = true })
highlight("Material_VimFolded", {
  fg = c.neutral.midpoint_strong,
  bg = color_table(hue_neutral, 3),
})
highlight("Material_VimSearch", {
  bg = color_table("yellow", 6),
  bg_dark = color_table("yellow", 10, { invert_dark = false }),
})
highlight("Material_VimIncSearch", {
  bg = color_table("orange", 6),
  bg_dark = color_table("orange", 9, { invert_dark = false }),
  bold = true,
})
highlight("Material_VimMatchParen", { bg = color_table("teal", 2) })

-- LSP {{{3

highlight("Material_LspReferenceText", {
  bg = color_table("yellow", 3),
  bg_dark = color_table("yellow", 10, { invert_dark = false }),
})
highlight("Material_LspReferenceRead", { bg = color_table("green", 2) })
highlight("Material_LspReferenceWrite", { bg = color_table("blue", 2) })

-- Testing {{{3

highlight("Material_DebugTest", {
  fg = color_table("blue", 4),
  bg = color_table("green", 9),
  sp = color_table("red", 3),
  bold = true,
  italic = true,
  undercurl = true,
})

-- Syntax {{{3
-- Built-in {{{4

-- Comment and linked groups
highlight("Material_SynComment", { fg = c.neutral.midpoint_strong })

-- Constant and linked groups
highlight("Material_SynConstant", {
  fg = color_table("blue_grey", 7),
  bg = color_table("blue_grey", 1),
})
highlight("Material_SynString", {
  fg = color_table("green", 7),
  bg = color_table("green", 1),
})
highlight("Material_SynCharacter", {
  fg = color_table("light_green", 7),
  bg = color_table("light_green", 1),
})
highlight("Material_SynNumber", {
  fg = color_table("blue", 7),
  bg = c.syntax.number.light,
})
highlight("Material_SynBoolean", {
  fg = color_table("orange", 7),
  bg = color_table("orange", 1),
})
highlight("Material_SynFloat", {
  fg = color_table("light_blue", 7),
  bg = color_table("light_blue", 1),
})

-- Statement and linked groups
highlight("Material_SynStatement", {
  fg = color_table("orange", 7),
  bold = true,
})
highlight("Material_SynOperator", { fg = color_table("orange", 7) })

-- PreProc and linked groups
highlight("Material_SynPreProc", { fg = color_table("teal", 5), bold = true })

-- Type and linked groups
highlight("Material_SynStorageClass", {
  fg = color_table("yellow", 8),
  bold = true,
})

-- Special and linked groups
highlight("Material_SynSpecial", { fg = color_table("red", 7) })
highlight("Material_SynSpecialChar", {
  fg = color_table("red", 7),
  bg = color_table("green", 1),
})

-- Underlined and linked groups
highlight("Material_SynUnderlined", {
  fg = color_table("blue", 7),
  underline = true,
})

-- Todo and linked groups
highlight("Material_SynTodo", { bold = true })

-- Custom {{{4
-- General {{{5

-- Member variables
highlight("Material_SynFieldName", { fg = color_table("blue", 6) })

-- Other value holders
highlight("Material_SynConstantName", {
  fg = color_table("orange", 5),
  italic = true,
})
highlight("Material_SynLocalName", { fg = color_table("orange", 5) })
highlight("Material_SynParameterName", { fg = color_table("orange", 9) })

-- Functions and methods
highlight("Material_SynFunctionKeyword", {
  fg = c.syntax["function"],
  bold = true,
})
highlight("Material_SynFunctionName", { fg = c.syntax["function"] })
highlight("Material_SynAccessorKeyword", {
  fg = color_table("cyan", 6),
  bold = true,
})
highlight("Material_SynAccessorName", { fg = color_table("cyan", 6) })
highlight("Material_SynAnonymousFunctionName", {
  fg = c.syntax["function"],
  bg = c.syntax.meta.light,
})

-- Types (primitive types and similar)
highlight("Material_SynTypeKeyword", { fg = c.syntax.type, bold = true })
highlight("Material_SynTypeName", { fg = c.syntax.type })

-- Structures (smaller than classes, but not quite primitive types)
highlight("Material_SynStructureKeyword", {
  fg = c.syntax.structure,
  bold = true,
})
highlight("Material_SynStructureName", { fg = c.syntax.structure })

-- Enums (same as structures, but with enumerated variants)
highlight("Material_SynEnumKeyword", {
  fg = c.syntax.structure,
  bg = c.syntax.number.light,
  bold = true,
})
highlight("Material_SynEnumName", {
  fg = c.syntax.structure,
  bg = c.syntax.number.light,
})

-- Typedefs (Classes and equally large/extensible things)
highlight("Material_SynTypedefKeyword", { fg = c.syntax.typedef, bold = true })
highlight("Material_SynTypedefName", { fg = c.syntax.typedef })

-- Namespaces (or anything that groups together definitions)
highlight("Material_SynNamespaceKeyword", {
  fg = c.syntax.namespace,
  bold = true,
})
highlight("Material_SynNamespaceName", { fg = c.syntax.namespace })

-- Generics
highlight("Material_SynGenericSpecial", { fg = color_table("purple", 4) })
highlight("Material_SynGenericBackground", { bg = c.syntax.meta.light })
highlight("Material_SynGenericParameterName", {
  fg = color_table("orange", 6),
  bg = c.syntax.meta.light,
})
highlight("Material_SynAnnotation", { fg = c.syntax.meta.strong })

-- Interfaces (or anything that is just a declaration, but not implementation)
highlight("Material_SynInterfaceKeyword", {
  fg = c.syntax.meta.strong,
  bold = true,
})
highlight("Material_SynInterfaceName", { fg = c.syntax.meta.strong })

-- Modifiers {{{5

highlight("Material_SynModAbstract", { bg = color_table("purple", 1) })
highlight("Material_SynModAsync", { bg = color_table("yellow", 2) })
highlight("Material_SynModReadonly", { italic = true })
highlight("Material_SynModStatic", { bold = true })
highlight("Material_SynModDeprecated", { strikethrough = true })

-- File type specific {{{5

highlight("Material_SynVimCommentString", { fg = color_table("green", 5) })

-- Plugins {{{3
-- lualine | nvim-lualine/lualine.nvim {{{4

highlight("Material_Lualine1", {
  fg = c.neutral.midpoint_strong,
  bg = color_table(hue_neutral, 2),
})
highlight("Material_Lualine3", {
  fg = c.neutral.lightest,
  bg = c.neutral.strong,
})

highlight("Material_LualineInsert", {
  fg = c.neutral.lightest,
  bg = color_table(hue_insert, 7),
  bold = true,
})
highlight("Material_LualineReplace", {
  fg = c.neutral.lightest,
  bg = color_table(hue_replace, 7),
  bold = true,
})

highlight("Material_LualineModified", {
  fg = c.neutral.lightest,
  bg = color_table("purple", 8),
})

-- Linked highlight groups {{{1
-- Non-editor window highlights {{{2
-- Framing {{{3

highlight("MsgSeparator", { link = "Material_VimStrongFramingWithoutFg" })
highlight("TabLineFill", { link = "Material_VimStrongFramingWithoutFg" })
highlight("VertSplit", { link = "Material_VimStrongFramingWithoutFg" })

highlight("FoldColumn", { link = "Material_VimLightFramingSubtleFg" })
highlight("SignColumn", { link = "Material_VimLightFramingSubtleFg" })
highlight("LineNr", { link = "Material_VimLightFramingSubtleFg" })

highlight("ColorColumn", { link = "Material_VimLighterFraming" })

highlight("CursorLineNr", { link = "Material_VimCursorLinesNum" })

highlight("TabLine", { link = "Material_VimLightFramingStrongFg" })
highlight("TabLineSel", { link = "Material_VimNormal" })
highlight("Title", { link = "Material_VimTitle" })

highlight("StatusLine", { link = "Material_VimStatusLine" })
highlight("StatusLineNC", { link = "Material_VimStatusLineNC" })
highlight("StatusLineTerm", { link = "Material_VimStatusLine" })
highlight("StatusLineTermNC", { link = "Material_VimStatusLineNC" })

highlight("WildMenu", { link = "Material_VimWildMenu" })

-- Popup menu and floating windows {{{3

highlight("Pmenu", { link = "Material_VimPopup" })
highlight("PmenuSel", { link = "Material_VimPopupSelected" })
highlight("PmenuSbar", { link = "Material_VimPopupScrollbar" })
highlight("PmenuThumb", { link = "Material_VimPopupThumb" })
highlight("NormalFloat", { link = "Material_VimPopup" })

-- Editor window highlights {{{2
-- Normal text {{{3

-- for the Normal group, see the definition of Material_VimNormal
highlight("NonText", { link = "Material_VimNormalLight" })
highlight("NormalNC", { link = "Material_VimNormal" })
highlight("MsgArea", { link = "Material_VimNormal" })

-- Cursor {{{3

highlight("Cursor", { link = "Material_VimCursor" })
highlight("CursorInsert", { link = "Material_VimCursorInsert" })
highlight("CursorReplace", { link = "Material_VimCursorReplace" })
highlight("CursorIM", { link = "Material_DebugTest" })
highlight("CursorColumn", { link = "Material_VimCursorLines" })
highlight("CursorLine", { link = "Material_VimCursorLines" })
highlight("IncSearch", { link = "Material_VimIncSearch" })
highlight("MatchParen", { link = "Material_VimMatchParen" })
highlight("QuickFixLine", { link = "Material_VimVisual" })
highlight("Search", { link = "Material_VimSearch" })
highlight("Substitute", { link = "Material_VimSearch" })
highlight("TermCursor", { link = "Material_VimCursor" })
highlight("TermCursorNC", { link = "Material_VimCursorUnfocused" })
highlight("Visual", { link = "Material_VimVisual" })
highlight("VisualNOS", { link = "Material_VimDiffLineText" })

-- Special character visualization {{{3

highlight("Conceal", { link = "Material_VimConceal" })
highlight("EndOfBuffer", { link = "Material_VimNormalLight" })
highlight("SpecialKey", { link = "Material_VimSpecialKey" })
highlight("Whitespace", { link = "Material_VimNormalLight" })

-- Diff {{{3

highlight("DiffAdd", { link = "Material_VimDiffLineAdd" })
highlight("DiffChange", { link = "Material_VimDiffLineChange" })
highlight("DiffDelete", { link = "Material_VimDiffLineDelete" })
highlight("DiffText", { link = "Material_VimDiffLineText" })

-- Spelling {{{3

highlight("SpellBad", { link = "Material_VimSpellBad" })
highlight("SpellCap", { link = "Material_VimSpellCap" })
highlight("SpellLocal", { link = "Material_VimSpellLocal" })
highlight("SpellRare", { link = "Material_VimSpellRare" })

-- Diagnostics {{{3

highlight("DiagnosticError", { link = "Material_VimErrorInverted" })
highlight("DiagnosticWarn", { link = "Material_VimWarningInverted" })
highlight("DiagnosticInfo", { link = "Material_VimInfoInverted" })
highlight("DiagnosticHint", { link = "Material_VimHintInverted" })

highlight("DiagnosticUnderLineError", { link = "Material_VimErrorUnderline" })
highlight("DiagnosticUnderLineWarn", { link = "Material_VimWarningUnderline" })
highlight("DiagnosticUnderLineInfo", { link = "Material_VimInfoUnderline" })
highlight("DiagnosticUnderLineHint", { link = "Material_VimHintUnderline" })

-- Special items {{{2

highlight("Directory", { link = "Material_VimDirectory" })
highlight("Folded", { link = "Material_VimFolded" })

-- Messages {{{2

highlight("ErrorMsg", { link = "Material_VimErrorInverted" })
highlight("ModeMsg", { link = "Material_VimModeMsg" })
highlight("MoreMsg", { link = "Material_VimMoreMsg" })
highlight("Question", { link = "Material_VimMoreMsg" })
highlight("WarningMsg", { link = "Material_VimWarningInverted" })

-- Syntax groups {{{2

highlight("Comment", { link = "Material_SynComment" })

highlight("Constant", { link = "Material_SynConstant" })
highlight("String", { link = "Material_SynString" })
highlight("Character", { link = "Material_SynCharacter" })
highlight("Number", { link = "Material_SynNumber" })
highlight("Boolean", { link = "Material_SynBoolean" })
highlight("Float", { link = "Material_SynFloat" })

highlight("Identifier", { link = "Material_SynStructureName" })
highlight("Function", { link = "Material_SynFunctionName" })

highlight("Statement", { link = "Material_SynStatement" })
highlight("Operator", { link = "Material_SynOperator" })

highlight("PreProc", { link = "Material_SynPreProc" })

highlight("Type", { link = "Material_SynTypeKeyword" })
highlight("StorageClass", { link = "Material_SynStorageClass" })
highlight("Structure", { link = "Material_SynStructureKeyword" })
highlight("Typedef", { link = "Material_SynTypedefKeyword" })

highlight("Special", { link = "Material_SynSpecial" })
highlight("SpecialChar", { link = "Material_SynSpecialChar" })

highlight("Underlined", { link = "Material_SynUnderlined" })

highlight("Error", { link = "Material_VimErrorInverted" })

highlight("Todo", { link = "Material_SynTodo" })

-- Treesitter {{{3

highlight("@accessor.keyword", { link = "Material_SynAccessorKeyword" })
highlight("@accessor.name", { link = "Material_SynAccessorName" })
highlight("@attribute", { link = "Material_SynAnnotation" })
highlight("@class.keyword", { link = "Material_SynTypedefKeyword" })
highlight("@class.name", { link = "Material_SynTypedefName" })
highlight("@comment.keyword", { link = "Material_SynStatement" })
highlight("@constant", { link = "Material_SynConstantName" })
highlight("@constant.builtin", { link = "Material_SynConstant" })
highlight("@constructor", { link = "Material_SynFunctionName" })
highlight("@enum.keyword", { link = "Material_SynEnumKeyword" })
highlight("@enum.name", { link = "Material_SynEnumName" })
highlight("@field", { link = "Material_SynFieldName" })
highlight("@function.keyword", { link = "Material_SynFunctionKeyword" })
highlight("@function.name", { link = "Material_SynFunctionName" })
highlight("@generic.special", { link = "Material_SynGenericSpecial" })
highlight("@interface.keyword", { link = "Material_SynInterfaceKeyword" })
highlight("@interface.name", { link = "Material_SynInterfaceName" })
highlight("@local.name", { link = "Material_SynLocalName" })
highlight("@namespace", { link = "Material_SynNamespaceName" })
highlight("@namespace.keyword", { link = "Material_SynNamespaceKeyword" })
highlight("@namespace.name", { link = "Material_SynNamespaceName" })
highlight("@parameter", { link = "Material_SynParameterName" })
highlight("@property", { link = "Material_SynAccessorName" })
highlight("@tag", { link = "Material_SynStatement" })
highlight("@tag.delimiter", { link = "Material_SynSpecial" })
highlight("@text.literal", { link = "Material_SynString" })
highlight("@text.reference", { link = "Material_SynUnderlined" })
highlight("@text.title", { link = "Material_VimTitle" })
highlight("@text.uri", { link = "Material_SynUnderlined" })
highlight("@type", { link = "Material_SynStructureName" })
highlight("@type.builtin", { link = "Material_SynTypeName" })
highlight("@variable", { link = "Material_SynLocalName" })
highlight("@variable.builtin", { link = "Material_SynSpecial" })

-- TSNone     ctermfg=241 guifg=foreground
-- TSVariable cleared

-- TSAnnotation          links  to  PreProc
-- TSConstMacro          links  to  Define
-- TSDanger              links  to  WarningMsg
-- TSEnvironment         links  to  Macro
-- TSEnvironmentName     links  to  Type
-- TSException           links  to  Exception
-- TSFuncBuiltin         links  to  Special
-- TSFuncMacro           links  to  Macro
-- TSLabel               links  to  Label
-- TSMath                links  to  Special
-- TSNote                links  to  SpecialComment
-- TSPunctBracket        links  to  Delimiter
-- TSPunctDelimiter      links  to  Delimiter
-- TSPunctSpecial        links  to  Delimiter
-- TSSymbol              links  to  Identifier
-- TSTag                 links  to  Label
-- TSTagAttribute        links  to  TSProperty
-- TSTagDelimiter        links  to  Delimiter
-- TSText                links  to  TSNone
-- TSTextReference       links  to  Constant
-- TSTitle               links  to  Title
-- TSWarning             links  to  Todo

-- commentTSConstant      links  to  TSConstant
-- queryTSPunctBracket    links  to  TSPunctBracket
-- queryTSVariable        links  to  TSVariable
-- queryTSString          links  to  TSString
-- queryTSPunctSpecial    links  to  TSPunctSpecial
-- queryTSType            links  to  TSType
-- queryTSProperty        links  to  TSProperty
-- queryTSPunctDelimiter  links  to  TSPunctDelimiter

-- LSP {{{3

-- References {{{4

highlight("LspReferenceText", { link = "Material_LspReferenceText" })
highlight("LspReferenceRead", { link = "Material_LspReferenceRead" })
highlight("LspReferenceWrite", { link = "Material_LspReferenceWrite" })

-- Code Lens {{{4

highlight("LspCodeLens", { link = "Material_SynComment" })
highlight("LspCodeLensSeparator", { link = "Material_SynComment" })

-- Signature Help {{{4

highlight("LspSignatureActiveParameter", { link = "Material_VimSearch" })

-- Semantic Highlighting {{{4

highlight("LspClass", { link = "Material_SynTypedefName" })
highlight("LspComment", { link = "Material_SynComment" })
highlight("LspDecorator", { link = "Material_SynAnnotation" })
highlight("LspEnum", { link = "Material_SynEnumKeyword" })
highlight("LspEnumMember", { link = "Material_SynEnumName" })
highlight("LspEvent", { link = "Material_DebugTest" })
highlight("LspFunction", { link = "Material_SynFunctionName" })
highlight("LspInterface", { link = "Material_SynInterfaceName" })
highlight("LspKeyword", { link = "Material_SynStatement" })
highlight("LspMacro", { link = "Material_DebugTest" })
highlight("LspMethod", { link = "Material_SynFunctionName" })
highlight("LspModifier", { link = "Material_SynStatement" })
highlight("LspNamespace", { link = "Material_SynNamespaceName" })
highlight("LspNumber", { link = "Material_SynNumber" })
highlight("LspOperator", { link = "Material_SynOperator" })
highlight("LspParameter", { link = "Material_SynParameterName" })
highlight("LspProperty", { link = "Material_SynAccessorName" })
highlight("LspRegexp", { link = "Material_DebugTest" })
highlight("LspString", { link = "Material_SynString" })
highlight("LspStruct", { link = "Material_SynStructureName" })
highlight("LspType", { link = "Material_SynStructureName" })
highlight("LspTypeParameter", { link = "Material_SynGenericParameterName" })
highlight("LspVariable", { link = "Material_SynLocalName" })

highlight("LspAbstract", { link = "Material_SynModAbstract" })
highlight("LspAsync", { link = "Material_SynModAsync" })
highlight("LspDeprecated", { link = "Material_SynModDeprecated" })
highlight("LspReadonly", { link = "Material_SynModReadonly" })
highlight("LspStatic", { link = "Material_SynModStatic" })

-- custom variables {{{1
-- terminal color variables {{{2

vim.g.terminal_color_0 = color_table("grey", 9).gui
vim.g.terminal_color_1 = color_table("red", 6).gui
vim.g.terminal_color_2 = color_table("light_green", 6).gui
vim.g.terminal_color_3 = color_table("amber", 8).gui
vim.g.terminal_color_4 = color_table("blue", 6).gui
vim.g.terminal_color_5 = color_table("purple", 6).gui
vim.g.terminal_color_6 = color_table("cyan", 6).gui
vim.g.terminal_color_7 = color_table("grey", 6).gui
vim.g.terminal_color_8 = color_table("grey", 5).gui
vim.g.terminal_color_9 = color_table("red", 4).gui
vim.g.terminal_color_10 = color_table("light_green", 4).gui
vim.g.terminal_color_11 = color_table("amber", 6).gui
vim.g.terminal_color_12 = color_table("blue", 4).gui
vim.g.terminal_color_13 = color_table("purple", 4).gui
vim.g.terminal_color_14 = color_table("cyan", 4).gui
vim.g.terminal_color_15 = color_table("grey", 4).gui

-- custom highlight groups {{{1
-- File type highlight groups {{{2
-- cs (C#) {{{3

highlight("csBraces", { link = "Material_SynSpecial" })
highlight("csClass", { link = "Material_SynTypedefKeyword" })
highlight("csClassType", { link = "Material_SynTypedefName" })
highlight("csEndColon", { link = "Material_SynSpecial" })
highlight("csGeneric", { link = "Material_SynGenericBackground" })
highlight("csNewType", { link = "Material_SynTypedefName" })
highlight("csParens", { link = "Material_SynSpecial" })
highlight("csStorage", { link = "Material_SynNamespaceKeyword" })

-- css {{{3

highlight("cssBraces", { link = "Material_SynSpecial" })
highlight("cssClassName", { link = "Material_SynTypedefName" })
highlight("cssFunction", { link = "NONE" })
highlight("cssIdentifier", { link = "Material_SynTypedefKeyword" })
highlight("cssImportant", { link = "Material_SynStatement" })
highlight("cssNoise", { link = "Material_SynSpecial" })
highlight("cssProp", { link = "Material_SynFieldName" })
highlight("cssSelectorOp", { link = "Material_SynOperator" })

-- fish {{{3

highlight("fishStatement", { link = "Material_SynFunctionName" })

-- gitcommit {{{3

highlight("gitCommitBlank", { link = "Material_VimStyleErrorUnderline" })
highlight("gitcommitOverflow", { link = "Material_VimStyleWarningUnderline" })

-- html {{{3

highlight("htmlArg", { link = "Material_SynFieldName" })
highlight("htmlEndTag", { link = "Material_SynSpecial" })
highlight("htmlTag", { link = "Material_SynStructureKeyword" })

-- java {{{3

highlight("javaBraces", { link = "Material_SynSpecial" })
highlight("javaC_", { link = "Material_SynTypedefName" })
highlight("javaClassDecl", { link = "Material_SynTypedefKeyword" })
highlight("javaDocParam", { link = "Material_SynParameterName" })
highlight("javaLangObject", { link = "Material_SynFunctionName" })
highlight("javaParen", { link = "Material_SynSpecial" })
highlight("javaParen1", { link = "Material_SynSpecial" })
highlight("javaParen2", { link = "Material_SynSpecial" })
highlight("javaR_", { link = "Material_SynTypedefName" })
highlight("javaX_", { link = "Material_SynTypedefName" })

-- javascript {{{3

highlight("jsArrowFunction", { link = "Material_SynFunctionKeyword" })
highlight("jsBrackets", { link = "Material_SynSpecial" })
highlight("jsClassBraces", { link = "Material_SynSpecial" })
highlight("jsClassDefinition", { link = "Material_SynTypedefName" })
highlight("jsDestructuringBraces", { link = "Material_SynSpecial" })
highlight("jsDot", { link = "Material_SynOperator" })
highlight("jsFuncArgCommas", { link = "Material_SynSpecial" })
highlight("jsFuncArgs", { link = "Material_SynParameterName" })
highlight("jsFuncBraces", { link = "Material_SynSpecial" })
highlight("jsFuncParens", { link = "Material_SynSpecial" })
highlight("jsFunction", { link = "Material_SynFunctionKeyword" })
highlight("jsFunctionKey", { link = "Material_SynFunctionName" })
highlight("jsIfElseBraces", { link = "Material_SynSpecial" })
highlight("jsModuleBraces", { link = "Material_SynSpecial" })
highlight("jsNoise", { link = "Material_SynSpecial" })
highlight("jsObjectBraces", { link = "Material_SynStructureKeyword" })
highlight("jsObjectColon", { link = "Material_SynSpecial" })
highlight("jsObjectKey", { link = "Material_SynFieldName" })
highlight("jsObjectProp", { link = "Material_SynFieldName" })
highlight("jsObjectSeparator", { link = "Material_SynSpecial" })
highlight("jsParens", { link = "Material_SynSpecial" })
highlight("jsRepeatBraces", { link = "Material_SynSpecial" })
highlight("jsSwitchBraces", { link = "Material_SynSpecial" })
highlight("jsSwitchColon", { link = "Material_SynSpecial" })
highlight("jsThis", { link = "Material_SynStatement" })
highlight("jsTryCatchBraces", { link = "Material_SynSpecial" })
highlight("jsVariableDef", { link = "Material_SynLocalName" })

-- json {{{3

highlight("jsonKeyword", { link = "Material_SynFieldName" })
highlight("jsonNoise", { link = "Material_SynSpecial" })
highlight("jsonNull", { link = "Material_SynConstant" })

-- Treesitter {{{4

highlight("jsonTSLabel", { link = "Material_SynFieldName" })

-- jsonc {{{3

highlight("jsoncBraces", { link = "Material_SynSpecial" })
highlight("jsoncKeywordMatch", { link = "Material_SynFieldName" })

-- Treesitter {{{4

highlight("jsoncTSLabel", { link = "Material_SynFieldName" })

-- JSP {{{3

highlight("jspTag", { link = "Material_SynPreProc" })

-- lua {{{3

highlight("luaFuncCall", { link = "Material_SynFunctionName" })
highlight("luaFuncKeyword", { link = "Material_SynFunctionKeyword" })

-- make {{{3

highlight("makeCommands", { link = "Material_SynConstant" })

-- markdown {{{3

highlight("mkdCodeDelimiter", { link = "Material_SynSpecialChar" })
highlight("mkdCodeEnd", { link = "Material_SynSpecialChar" })
highlight("mkdCodeStart", { link = "Material_SynSpecialChar" })
highlight("mkdHeading", { link = "Material_SynSpecial" })
highlight("mkdListItem", { link = "Material_SynSpecial" })

-- mustache/handlebars {{{3

highlight("mustacheHelpers", { link = "Material_SynOperator" })
highlight("mustacheHbsComponent", { link = "Material_SynFieldName" })

-- ruby {{{3

highlight("rubyClass", { link = "Material_SynTypedefKeyword" })
highlight("rubyClassName", { link = "Material_SynTypedefName" })
highlight("rubyConstant", { link = "Material_SynTypedefName" })
highlight("rubyModule", { link = "Material_SynNamespaceKeyword" })
highlight("rubyModuleName", { link = "Material_SynNamespaceName" })
highlight("rubyPredefinedConstant", { link = "Material_SynConstantName" })
highlight("rubyPseudoOperator", { link = "Material_SynOperator" })
highlight("rubyStringDelimiter", { link = "Material_SynSpecialChar" })

-- rust {{{3

highlight("rustEnumVariant", { link = "Material_SynEnumName" })
highlight("rustEnum", { link = "Material_SynEnumKeyword" })
highlight("rustModPath", { link = "Material_SynNamespaceName" })
highlight("rustStructure", { link = "Material_SynStructureKeyword" })
highlight("rustType", { link = "Material_SynTypedefName" })

-- sh {{{3

highlight("shDerefVar", { link = "Material_SynStructureName" })
highlight("shOption", { link = "Material_SynParameterName" })
highlight("shStatement", { link = "Material_SynFunctionName" })
highlight("shQuote", { link = "Material_SynSpecialChar" })

-- Typescript {{{3

highlight("typescriptAliasDeclaration", { link = "Material_SynTypedefName" })
highlight("typescriptAliasKeyword", { link = "Material_SynTypedefKeyword" })
highlight("typescriptAmbientDeclaration", { link = "Material_SynStatement" })
highlight("typescriptArrowFunc", { link = "Material_SynFunctionKeyword" })
highlight("typescriptAssign", { link = "Material_SynOperator" })
highlight("typescriptBinaryOp", { link = "Material_SynOperator" })
highlight("typescriptBraces", { link = "Material_SynSpecial" })
highlight("typescriptCall", { link = "Material_SynParameterName" })
highlight("typescriptClassKeyword", { link = "Material_SynTypedefKeyword" })
highlight("typescriptClassName", { link = "Material_SynTypedefName" })
highlight(
  "typescriptClassTypeParameter",
  { link = "Material_SynGenericBackground" }
)
highlight("typescriptDotNotation", { link = "Material_SynOperator" })
highlight("typescriptEndColons", { link = "Material_SynSpecial" })
highlight("typescriptEnumKeyword", { link = "Material_SynEnumKeyword" })
highlight("typescriptExceptions", { link = "Material_SynStatement" })
highlight("typescriptExport", { link = "Material_SynStatement" })
highlight("typescriptFuncComma", { link = "Material_SynSpecial" })
highlight("typescriptGlobalMathDot", { link = "Material_SynOperator" })
highlight("typescriptGlobalPromiseDot", { link = "Material_SynOperator" })
highlight("typescriptIdentifierName", { link = "Material_SynStructureName" })
highlight("typescriptImport", { link = "Material_SynStatement" })
highlight(
  "typescriptInterfaceKeyword",
  { link = "Material_SynInterfaceKeyword" }
)
highlight("typescriptInterfaceName", { link = "Material_SynInterfaceName" })
highlight("typescriptMember", { link = "Material_SynFieldName" })
highlight("typescriptMemberOptionality", { link = "Material_SynOperator" })
highlight("typescriptModule", { link = "Material_SynNamespaceKeyword" })
highlight("typescriptNull", { link = "Material_SynConstant" })
highlight("typescriptObjectColon", { link = "Material_SynSpecial" })
highlight("typescriptObjectLabel", { link = "Material_SynFieldName" })
highlight("typescriptOptionalMark", { link = "Material_SynOperator" })
highlight("typescriptParens", { link = "Material_SynSpecial" })
highlight("typescriptPredefinedType", { link = "Material_SynTypeName" })
highlight("typescriptProp", { link = "Material_SynFieldName" })
highlight("typescriptRestOrSpread", { link = "Material_SynOperator" })
highlight("typescriptTry", { link = "Material_SynStatement" })
highlight("typescriptTypeAnnotation", { link = "Material_SynSpecial" })
highlight("typescriptTypeBracket", { link = "Material_SynSpecial" })
highlight("typescriptTypeBrackets", { link = "Material_SynGenericSpecial" })
highlight(
  "typescriptTypeParameter",
  { link = "Material_SynGenericParameterName" }
)
highlight("typescriptVariable", { link = "Material_SynStatement" })
highlight("typescriptVariableDeclaration", { link = "Material_SynLocalName" })

-- vim (VimScript|VimL) {{{3

highlight("vimCommentString", { link = "Material_SynVimCommentString" })
highlight("vimEnvvar", { link = "Material_SynStructureName" })
highlight("vimFunction", { link = "Material_SynFunctionName" })
highlight("vimHiBang", { link = "Material_SynSpecial" })
highlight("vimUserFunc", { link = "Material_SynFunctionName" })

-- yaml {{{3

highlight("yamlBlockMappingKey", { link = "Material_SynFieldName" })

-- yardoc {{{3

-- Fix the wrongly linked groups in noprompt/vim-yardoc.
highlight("yardYield", { link = "yardGenericTag" })
highlight("yardYieldParam", { link = "yardGenericTag" })
highlight("yardYieldReturn", { link = "yardGenericTag" })

-- Customize some highlight groups for noprompt/vim-yardoc.
highlight("yardDuckType", { link = "Material_SynFunctionName" })
highlight("yardGenericTag", { link = "Material_SynSpecial" })
highlight("yardLiteral", { link = "Material_SynConstant" })
highlight("yardParamName", { link = "Material_SynParameterName" })
highlight("yardType", { link = "Material_SynTypedefName" })

-- zsh {{{3

highlight("zshFlag", { link = "Material_SynParameterName" })

-- highlight groups for plugins {{{2

-- CSV | chrisbra/csv {{{3

highlight("CSVColumnHeaderOdd", { link = "Material_VimTitle" })
highlight("CSVColumnHeaderEven", { link = "Material_VimTitle" })

-- Log | MTDL9/vim-log-Highlighting {{{3

highlight("logLevelTrace", { link = "Material_VimTraceInverted" })
highlight("logLevelDebug", { link = "Material_VimDebugInverted" })
highlight("logLevelNotice", { link = "Material_VimHintInverted" })
highlight("logLevelInfo", { link = "Material_VimInfoInverted" })
highlight("logLevelWarning", { link = "Material_VimWarningInverted" })
highlight("logLevelError", { link = "Material_VimErrorInverted" })

highlight("logBrackets", { link = "Material_SynSpecial" })

-- vim-git | tpope/vim-git {{{3

highlight("diffAdded", { link = "Material_VimDiffAdd" })
highlight("diffRemoved", { link = "Material_VimDiffDelete" })

-- gitsigns | lewis6991/gitsigns.nvim {{{3

highlight("GitSignsAdd", { link = "Material_VimDiffSignAdd" })
highlight("GitSignsAddLn", { link = "Material_VimDiffLineAdd" })
highlight("GitSignsAddInline", { link = "Material_VimDiffLineText" })
highlight("GitSignsChange", { link = "Material_VimDiffSignChange" })
highlight("GitSignsChangeLn", { link = "Material_VimDiffLineChange" })
highlight("GitSignsChangeInline", { link = "Material_VimDiffLineText" })
highlight("GitSignsDelete", { link = "Material_VimDiffSignDelete" })
highlight("GitSignsDeleteLn", { link = "Material_VimDiffLineDelete" })
highlight("GitSignsDeleteInline", { link = "Material_VimDiffLineText" })

-- nvim-cmp | hrsh7th/nvim-cmp {{{3

highlight("CmpItemAbbrDeprecated", { link = "Material_SynModDeprecated" })
highlight("CmpItemAbbrMatch", { bold = true })

highlight("CmpItemKindClass", { link = "Material_SynTypedefName" })
highlight("CmpItemKindConstant", { link = "Material_SynConstantName" })
highlight("CmpItemKindConstructor", { link = "Material_SynFunctionName" })
highlight("CmpItemKindEnum", { link = "Material_SynEnumKeyword" })
highlight("CmpItemKindEnumMember", { link = "Material_SynEnumName" })
highlight("CmpItemKindField", { link = "Material_SynFieldName" })
highlight("CmpItemKindFolder", { link = "Material_VimDirectory" })
highlight("CmpItemKindFunction", { link = "Material_SynFunctionName" })
highlight("CmpItemKindInterface", { link = "Material_SynInterfaceName" })
highlight("CmpItemKindKeyword", { link = "Material_SynStatement" })
highlight("CmpItemKindMethod", { link = "Material_SynFunctionName" })
highlight("CmpItemKindModule", { link = "Material_SynNamespaceName" })
highlight("CmpItemKindOperator", { link = "Material_SynOperator" })
highlight("CmpItemKindProperty", { link = "Material_SynAccessorName" })
highlight("CmpItemKindStruct", { link = "Material_SynStructureName" })
highlight("CmpItemKindTypeParameter", {
  link = "Material_SynGenericParameterName",
})
highlight("CmpItemKindVariable", { link = "Material_SynLocalName" })

-- nvim-notify | rcarriga/nvim-notify {{{3

highlight("NotifyDEBUGBorder", { link = "Material_VimDebugBorder" })
highlight("NotifyDEBUGIcon", { link = "Material_VimDebug" })
highlight("NotifyDEBUGTitle", { link = "Material_VimDebug" })
highlight("NotifyERRORBorder", { link = "Material_VimErrorBorder" })
highlight("NotifyERRORIcon", { link = "Material_VimError" })
highlight("NotifyERRORTitle", { link = "Material_VimError" })
highlight("NotifyINFOBorder", { link = "Material_VimInfoBorder" })
highlight("NotifyINFOIcon", { link = "Material_VimInfo" })
highlight("NotifyINFOTitle", { link = "Material_VimInfo" })
highlight("NotifyTRACEBorder", { link = "Material_VimTraceBorder" })
highlight("NotifyTRACEIcon", { link = "Material_VimTrace" })
highlight("NotifyTRACETitle", { link = "Material_VimTrace" })
highlight("NotifyWARNBorder", { link = "Material_VimWarningBorder" })
highlight("NotifyWARNIcon", { link = "Material_VimWarning" })
highlight("NotifyWARNTitle", { link = "Material_VimWarning" })
