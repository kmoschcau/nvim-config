local palette = require("colors.material.palette").palette

local M = {}

local normal_values = { 50, 100, 200, 300, 400, 500, 600, 700, 800, 900 }

local accent_values = { "A100", "A200", "A400", "A700" }

---@class HighlightConfig: vim.api.keyset.highlight
---
---The dark background override for the foreground color
---@field fg_dark? ColorDefinition | "NONE"
---
---The dark background override for the background color
---@field bg_dark? ColorDefinition | "NONE"
---
---The dark background override for the special color
---@field sp_dark? ColorDefinition | "NONE"

---Set the highlight group passed as group_name to the values specified in
---config.
---@param group_name string the name of the group
---@param config HighlightConfig the highlight config
---@return nil
M.highlight = function(group_name, config)
  local def = {}

  if config.fg then
    if config.fg == "NONE" then
      def.fg = "NONE"
      def.ctermfg = "NONE"
    else
      def.fg = config.fg.gui
      def.ctermfg = config.fg.cterm
    end
  end

  if config.bg then
    if config.bg == "NONE" then
      def.bg = "NONE"
      def.ctermbg = "NONE"
    else
      def.bg = config.bg.gui
      def.ctermbg = config.bg.cterm
    end
  end

  if config.sp then
    if config.sp == "NONE" then
      def.sp = "NONE"
    else
      def.sp = config.sp.gui
    end
  end

  if vim.o.background == "dark" then
    if config.fg_dark then
      if config.fg_dark == "NONE" then
        def.fg = "NONE"
        def.ctermfg = "NONE"
      else
        def.fg = config.fg_dark.gui
        def.ctermfg = config.fg_dark.cterm
      end
    end

    if config.bg_dark then
      if config.bg_dark == "NONE" then
        def.bg = "NONE"
        def.ctermbg = "NONE"
      else
        def.bg = config.bg_dark.gui
        def.ctermbg = config.bg_dark.cterm
      end
    end

    if config.sp_dark then
      if config.sp_dark == "NONE" then
        def.sp = "NONE"
      else
        def.sp = config.sp_dark.gui
      end
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

---@param invert_dark boolean
---@param flip_inversion boolean
---@return boolean
local function use_dark(invert_dark, flip_inversion)
  if not invert_dark then
    return flip_inversion
  end

  if flip_inversion then
    return vim.o.background == "light"
  else
    return vim.o.background == "dark"
  end
end

---Get the value number for the passed index, dependent on the 'background'.
---@param index number
---@param invert_dark boolean
---@param flip_inversion boolean
M.value = function(index, invert_dark, flip_inversion)
  local clamped = math.max(math.min(index, 10), 1)

  local value_index
  if use_dark(invert_dark, flip_inversion) then
    value_index = #normal_values - clamped + 1
  else
    value_index = clamped
  end

  return normal_values[value_index]
end

---Get the accent value string for the passed index, dependent on the
---'background'.
---@param index number
---@param invert_dark boolean
---@param flip_inversion boolean
M.accent_value = function(index, invert_dark, flip_inversion)
  local clamped = math.max(math.min(index, 4), 1)

  local value_index
  if use_dark(invert_dark, flip_inversion) then
    value_index = #accent_values - clamped + 1
  else
    value_index = clamped
  end

  return accent_values[value_index]
end

---@class ColorTableOptions
---
---whether to interpret the index as an accent index
---@field accent? boolean
---
---whether to invert the index when 'background' is dark (default true)
---@field invert_dark? boolean
---
---whether to flip the index inversion (meaning the decision whether to use
---light or dark colors is flipped based on background)
---@field flip_inversion? boolean

---Get a color table by the passed color name and the passed index, dependent
---on the 'background'.
---@param color_name string
---@param color_index number
---@param options? ColorTableOptions
M.color_table = function(color_name, color_index, options)
  local accent = false
  local invert_dark = true
  local flip_inversion = false
  if options then
    accent = options.accent or false
    invert_dark = options.invert_dark and true or false
    flip_inversion = options.flip_inversion or false
  end

  if accent then
    local raw_accent_value =
      M.accent_value(color_index, invert_dark, flip_inversion)
    local clamped_accent_value = vim
      .regex("brown|grey|blue_grey")
      :match_str(color_name) and raw_accent_value:sub(2) or raw_accent_value
    return palette[color_name][clamped_accent_value]
  else
    return palette[color_name][M.value(color_index, invert_dark, flip_inversion)]
  end
end

return M
