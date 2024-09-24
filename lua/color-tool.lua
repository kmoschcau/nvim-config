-- vim: foldmethod=marker

-- Setup {{{

-- Script configuration vars {{{

local THEME_NAME = "new"

-- Whether to open a buffer with data.
local SHOW_PREVIEW_BUFFER = true

-- The contrast threshold below which error diagnostics are created.
local CONTRAST_ERROR_THRESHOLD = 2

-- The contrast threshold below which error diagnostics are created.
local CONTRAST_WARNING_THRESHOLD = 3

-- Highlight group names, which should not be included in contrast diagnostics.
local CONTRAST_IGNORE = {
  "CursorInsert",
  "CursorReplace",
  "LazyProgressDone",
  "LazyProgressTodo",
  "NonText",
  "WinSeparator",
}

-- Whether to write configuration files for the scheme.
local WRITE_COLORSCHEME = true

-- }}}

-- Dependencies {{{

-- NOTE: All manipulation is done in Oklch color space.
-- Get interactive view at https://bottosson.github.io/misc/colorpicker/
-- Install https://github.com/echasnovski/mini.colors to have this working
local success, colors = pcall(require, "mini.colors")
if not success then
  vim.notify("Could not require mini.colors.", vim.log.levels.ERROR)
  return
end

-- }}}

-- Helper types {{{

--- @class MiniColorsRgb
--- @field r integer the red amount, 0 - 255
--- @field g integer the green amount, 0 - 255
--- @field b integer the blue amount, 0 - 255

--- @class MiniColorsOklab
--- @field l number the perceived lightness, 0 - 100
--- @field a number how green/red the color is, usually -30 - 30
--- @field b number how blue/yellow the color is, usually -30 - 30

--- @class MiniColorsOklch
--- @field l number the perceived lightness, 0 - 100
--- @field c number the chroma, usually 0 - 32
--- @field h number the hue, 0 - 360; nil for gray

--- @class MiniColorsOkhsl
--- @field h number the hue, 0 - 360; nil for gray
--- @field s number the percentile saturation of color, 0 - 100
--- @field l number the perceived lightness, 0 - 100

--- @alias MiniColorsColor
--- | number cterm color index between 16 and 255
--- | string a hex color string
--- | MiniColorsRgb
--- | MiniColorsOklab
--- | MiniColorsOklch
--- | MiniColorsOkhsl

--- @alias MiniColorsGamutClip
--- | "chroma"
--- | "lightness"
--- | "cusp"

-- }}}

-- Helper functions {{{

--- Shorthand function to convert an Oklch color table into a hex string.
--- @param l number the perceived lightness
--- @param c number the chroma
--- @param h number|nil the hue
--- @param gamut_clip MiniColorsGamutClip | nil the clip method, defaults to "chroma"
local function convert(l, c, h, gamut_clip)
  return colors.convert({ l = l, c = c, h = h }, "hex", {
    gamut_clip = gamut_clip or "chroma",
  }) --[[@as string]]
end

--- Create a table that contains a hex color for foreground and background. This
--- will create a color combination of the same hue, which has a strong
--- foreground and a light background of the same hue.
--- @param hue number|nil the hue to generate a color pair with, 0 - 360
--- @return { fg: string, bg: string }
local function make_syn_with_bg(hue)
  return {
    fg = convert(30, 100, hue),
    bg = convert(90, 5, hue),
  }
end

--- Invert the luminance of the given hex color.
--- @param val MiniColorsColor
--- @param gamut_clip MiniColorsGamutClip | nil the clip method, defaults to "lightness"
local function invert_l(val, gamut_clip)
  return colors.modify_channel(val, "lightness", function(l)
    return 100 - l
  end, { gamut_clip = gamut_clip or "lightness" }) --[[@as string]]
end

--- Shift the given color's perceived lightness.
--- @param val MiniColorsColor
--- @param L number
--- @param gamut_clip MiniColorsGamutClip | nil the clip method, defaults to "lightness"
local function modify_l(val, L, gamut_clip)
  return colors.modify_channel(val, "lightness", function(l)
    return l + L
  end, { gamut_clip = gamut_clip or "lightness" }) --[[@as string]]
end

--- Map a color to a dark background variant.
--- @param val MiniColorsColor|nil
--- @return string|nil
local function map_to_dark(val)
  if val == nil or val == "NONE" then
    return val
  end

  return modify_l(invert_l(val), 20)
end

--- Map a highlight group spec to a dark background version.
--- @param highlight vim.api.keyset.highlight
--- @return vim.api.keyset.highlight
local function map_hl_to_dark(highlight)
  return vim.tbl_extend("force", highlight, {
    fg = map_to_dark(highlight.fg),
    bg = map_to_dark(highlight.bg),
  })
end

--- Add cterm values to a highlight group spec, derived from its truecolor
--- fields.
--- @param highlights table<string, vim.api.keyset.highlight>
local function add_cterm_values(highlights)
  local function convert_to_8bit(color)
    if color == nil or color == "NONE" then
      return color
    end

    return require("mini.colors").convert(color, "8-bit")
  end

  for _, value in pairs(highlights) do
    value.ctermfg = convert_to_8bit(value.fg)
    value.ctermbg = convert_to_8bit(value.bg)
  end
end

--- Calculate the contrast ratio of the given foreground and background colors.
--- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef
--- @param fg MiniColorsColor
--- @param bg MiniColorsColor
--- @return number
local function get_contrast_ratio(fg, bg)
  -- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
  local function get_luminance(val)
    local rgb = colors.convert(val, "rgb") --[[@as MiniColorsRgb]]

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

--- Calculate the contrast ratio of the given highlight group.
--- @param highlight vim.api.keyset.highlight the highlight group
--- @param normal vim.api.keyset.highlight the "Normal" highlight group as fallback
--- @return number
local function get_highlight_contrast_ratio(highlight, normal)
  local function fallback_color(color, fallback)
    if color == nil or color == "NONE" then
      return fallback
    end

    return color
  end

  return get_contrast_ratio(
    fallback_color(highlight.fg, normal.fg),
    fallback_color(highlight.bg, normal.bg)
  )
end

--- Insert a header for the highlight preview buffer in the given lines.
--- @param lines string[] the lines to insert into
--- @param max_name_length integer the maximum length of highlight names
local function insert_highlight_preview_header(lines, max_name_length)
  table.insert(
    lines,
    string.format(
      "%4s %-" .. max_name_length .. "s %-8s %7s %7s %7s %7s %7s %5s %s",
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

--- Insert the preview lines for the given highlights into the given lines.
--- @param lines string[] the lines to insert into
--- @param hls table<string, vim.api.keyset.highlight> the highlights to preview
--- @param names string[] the highlight names in display order
--- @param max_name_length integer the maximum length of highlight names
local function insert_highlight_preview_lines(
  lines,
  hls,
  names,
  max_name_length
)
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

  for _, name in ipairs(names) do
    local hl = hls[name]

    if hl.link then
      table.insert(
        lines,
        string.format(
          "XXX  %-" .. max_name_length .. "s %54s -> %s",
          name,
          "",
          hl.link
        )
      )
    else
      table.insert(lines, (string
        .format(
          "XXX  %-" .. max_name_length .. "s %8.1f %7s %7s %7s %7s %7s %5d %s",
          name,
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

--- Insert the preview lines for the terminal colors into the given lines.
--- @param lines string[] the lines to insert into
--- @param clrs string[] the colors to preview
--- @param bg string the background color to contrast against
local function insert_terminal_colors_preview_lines(lines, clrs, bg)
  for index, value in ipairs(clrs) do
    table.insert(
      lines,
      string.format(
        "XXX  %2d %8.1f %7s",
        index - 1,
        get_contrast_ratio(value, bg),
        value
      )
    )
  end
end

--- Add an extmark highlight for a given preview line.
--- @param bufnr integer the ID of the buffer
--- @param name string the name of the preview highlight
--- @param spec vim.api.keyset.highlight the spec for the preview highlight
--- @param ext_ns integer the extmark namespace ID
--- @param line_index number the line index where to place the highlight
local function color_preview(bufnr, name, spec, ext_ns, line_index)
  vim.api.nvim_set_hl(0, name, spec)
  vim.api.nvim_buf_add_highlight(bufnr, ext_ns, name, line_index, 0, 3)
end

--- Check the given spec's contrast ratio and add a diagnostic if it is too low.
--- @param diagnostics vim.Diagnostic[] the diagnostics to append to
--- @param name string the name of the highlight to check
--- @param spec vim.api.keyset.highlight the highlight spec to check
--- @param max_name_length integer the maximum length of highlight names
--- @param normal vim.api.keyset.highlight the "Normal" highlight group as fallback
--- @param line_index integer where to place a potential diagnostic
local function check_contrast(
  diagnostics,
  name,
  spec,
  max_name_length,
  normal,
  line_index
)
  if vim.list_contains(CONTRAST_IGNORE, name) then
    return
  end

  local contrast = get_highlight_contrast_ratio(spec, normal)
  local number_length = #string.format("%.1f", contrast)

  if contrast < CONTRAST_ERROR_THRESHOLD then
    table.insert(diagnostics, {
      lnum = line_index,
      col = 5 + max_name_length + 9 - number_length,
      end_col = 5 + max_name_length + 9,
      severity = vim.diagnostic.severity.E,
      message = string.format(
        "%s: Contrast %.1f is below %.1f",
        name,
        contrast,
        CONTRAST_ERROR_THRESHOLD
      ),
      source = "color-tool",
      code = "contrast-below-error-threshold",
    })
  elseif contrast < CONTRAST_WARNING_THRESHOLD then
    table.insert(diagnostics, {
      lnum = line_index,
      col = 5 + max_name_length + 9 - number_length,
      end_col = 5 + max_name_length + 9,
      severity = vim.diagnostic.severity.W,
      message = string.format(
        "%s: Contrast %.1f is below %.1f",
        name,
        contrast,
        CONTRAST_WARNING_THRESHOLD
      ),
      source = "color-tool",
      code = "contrast-below-warning-threshold",
    })
  end
end

--- Add extmark highlights for the given highlights. This also adds diagnostics
--- entries for highlights with poor contrast.
--- @param bufnr integer the ID of the buffer
--- @param ext_ns integer the extmark namespace ID
--- @param start_after_line integer after which line to start
--- @param hls table<string, vim.api.keyset.highlight> the highlights to use
--- @param names string[] the highlight names in display order
--- @param max_name_length integer the maximum length of highlight names
--- @param normal vim.api.keyset.highlight the "Normal" highlight group as fallback
--- @param diagnostics vim.Diagnostic[] the diagnostics to append to
--- @param suffix "light" | "dark" the suffix to add to the highlights
local function color_highlight_preview_lines(
  bufnr,
  ext_ns,
  start_after_line,
  hls,
  names,
  max_name_length,
  diagnostics,
  normal,
  suffix
)
  for index, name in ipairs(names) do
    local hl = hls[name]
    local line_index = start_after_line + index

    --- @type vim.api.keyset.highlight | nil
    local spec
    if hl.link then
      local link_target = hls[hl.link]
      if link_target then
        spec = vim.tbl_extend("keep", link_target, normal)
      else
        spec = nil
      end
    else
      spec = vim.tbl_extend("keep", hl, normal)
    end
    if spec then
      color_preview(
        bufnr,
        name .. "_preview_" .. suffix,
        spec,
        ext_ns,
        line_index
      )

      if not hl.link then
        check_contrast(
          diagnostics,
          name,
          spec,
          max_name_length,
          normal,
          line_index
        )
      end
    end
  end
end

--- Add extmark highlights for the given terminal colors.
--- @param bufnr integer the ID of the buffer
--- @param ext_ns integer the extmark namespace ID
--- @param start_after_line integer after which line to start
--- @param clrs string[] the terminal colors to highlight
--- @param diagnostics vim.Diagnostic[] the diagnostics to append to
--- @param normal vim.api.keyset.highlight the "Normal" highlight group as fallback
--- @param suffix "light" | "dark" the suffix to add to the highlights
local function color_terminal_preview_lines(
  bufnr,
  ext_ns,
  start_after_line,
  clrs,
  diagnostics,
  normal,
  suffix
)
  for index, value in ipairs(clrs) do
    local name = "terminal_color_" .. index - 1 .. "_" .. suffix
    local line_index = start_after_line + index
    local spec = { fg = value, bg = normal.bg }

    color_preview(bufnr, name, spec, ext_ns, line_index)

    check_contrast(diagnostics, name, spec, 2, normal, line_index)
  end
end

--- Create a preview buffer for the color scheme.
--- @param highlights_light table<string, vim.api.keyset.highlight>
--- @param highlights_dark table<string, vim.api.keyset.highlight>
--- @param terminal_colors_light string[]
--- @param terminal_colors_dark string[]
local function create_preview_buffer(
  highlights_light,
  highlights_dark,
  terminal_colors_light,
  terminal_colors_dark
)
  -- FIXME: Make this whole thing less fragile and allow reloading when in the
  -- new buffer.
  -- TODO: Make the highlight colors survive a background color change.

  local names = vim.tbl_keys(highlights_light)
  table.sort(names)

  local max_name_length = math.max(unpack(vim.tbl_map(function(key)
    return #key
  end, names)))

  --- @type string[]
  local lines = {}

  vim.list_extend(lines, { "--- Highlights ---" })
  insert_highlight_preview_header(lines, max_name_length)
  vim.list_extend(lines, { "Light:" })
  insert_highlight_preview_lines(
    lines,
    highlights_light,
    names,
    max_name_length
  )
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "Dark:" })
  insert_highlight_preview_lines(lines, highlights_dark, names, max_name_length)
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "--- Terminal colors ---" })
  vim.list_extend(lines, { "Light:" })
  insert_terminal_colors_preview_lines(
    lines,
    terminal_colors_light,
    highlights_light.Normal.bg
  )
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "Dark:" })
  insert_terminal_colors_preview_lines(
    lines,
    terminal_colors_dark,
    highlights_dark.Normal.bg
  )

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(bufnr, "Color Tool Preview")
  vim.api.nvim_set_option_value("bufhidden", "delete", {
    buf = bufnr,
    scope = "local",
  })
  vim.keymap.set("n", "R", "<Cmd>source lua/color-tool.lua<CR>", {
    buffer = bufnr,
    silent = true,
    desc = "Reload the preview buffer.",
  })

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  --- @type vim.Diagnostic[]
  local diagnostics = {}

  local ext_ns = vim.api.nvim_create_namespace "highlight-previews-extmarks"

  local start_after_line = 2
  color_highlight_preview_lines(
    bufnr,
    ext_ns,
    start_after_line,
    highlights_light,
    names,
    max_name_length,
    diagnostics,
    highlights_light.Normal,
    "light"
  )

  start_after_line = start_after_line + vim.tbl_count(highlights_light) + 2
  color_highlight_preview_lines(
    bufnr,
    ext_ns,
    start_after_line,
    highlights_dark,
    names,
    max_name_length,
    diagnostics,
    highlights_dark.Normal,
    "dark"
  )

  start_after_line = start_after_line + vim.tbl_count(highlights_dark) + 3
  color_terminal_preview_lines(
    bufnr,
    ext_ns,
    start_after_line,
    terminal_colors_light,
    diagnostics,
    highlights_light.Normal,
    "light"
  )

  start_after_line = start_after_line + vim.tbl_count(terminal_colors_light) + 2
  color_terminal_preview_lines(
    bufnr,
    ext_ns,
    start_after_line,
    terminal_colors_dark,
    diagnostics,
    highlights_dark.Normal,
    "dark"
  )

  vim.diagnostic.set(
    vim.api.nvim_create_namespace "highlight-previews-diagnostics",
    bufnr,
    diagnostics
  )

  local winnr = vim.api.nvim_open_win(bufnr, true, { vertical = true })

  vim.api.nvim_set_option_value("spell", false, {
    scope = "local",
    win = winnr,
  })
  vim.api.nvim_set_option_value("wrap", false, {
    scope = "local",
    win = winnr,
  })
end

--- @param highlights_light table<string, vim.api.keyset.highlight>
--- @param highlights_dark table<string, vim.api.keyset.highlight>
local function write_nvim_colors(
  highlights_light,
  highlights_dark,
  terminal_colors_light,
  terminal_colors_dark,
  blend_light,
  blend_dark
)
  local file =
    io.open(vim.fn.stdpath "config" .. "/colors/" .. THEME_NAME .. ".lua", "w")
  if not file then
    vim.notify("Could not open nvim color scheme file.", vim.log.levels.WARN)
    return
  end

  local function insert_highlight_lines(lines, highlights)
    local keys = vim.tbl_keys(highlights)
    table.sort(keys)

    for _, key in ipairs(keys) do
      table.insert(
        lines,
        string.format(
          '  vim.api.nvim_set_hl(0, "%s", %s)',
          key,
          vim.inspect(highlights[key], { indent = "", newline = "" })
        )
      )
    end
  end

  local function insert_terminal_colors(lines, clrs)
    for index, color in ipairs(clrs) do
      table.insert(
        lines,
        string.format('  vim.g.terminal_color_%d = "%s"', index - 1, color)
      )
    end
  end

  local function insert_blend_lines(
    lines,
    hl_normal_float,
    hl_float_title,
    blend
  )
    local function highlight_with_blend(name, highlight, b)
      return string.format(
        '    vim.api.nvim_set_hl(0, "%s", %s)',
        name,
        vim.inspect(
          vim.tbl_extend("keep", highlight, { blend = b }),
          { indent = "", newline = "" }
        )
      )
    end

    vim.list_extend(lines, {
      "  if vim.g.neovide then",
      highlight_with_blend("NormalFloat", hl_normal_float, blend),
      highlight_with_blend("FloatTitle", hl_float_title, blend),
      string.format("    vim.o.pumblend = %s", blend),
      "  end",
    })
  end

  local lines = {
    "-- This is a theme generated by color-tool.lua.",
    "",
    'vim.cmd.highlight "clear"',
    'vim.g.colors_name = vim.fn.expand "<sfile>:t:r"',
    "",
    'if vim.o.background == "light" then',
  }
  insert_highlight_lines(lines, highlights_light)
  table.insert(lines, "")
  insert_terminal_colors(lines, terminal_colors_light)
  table.insert(lines, "")
  insert_blend_lines(
    lines,
    highlights_light.NormalFloat,
    highlights_light.FloatTitle,
    blend_light
  )
  table.insert(lines, "else")
  insert_highlight_lines(lines, highlights_dark)
  table.insert(lines, "")
  insert_terminal_colors(lines, terminal_colors_dark)
  table.insert(lines, "")
  insert_blend_lines(
    lines,
    highlights_dark.NormalFloat,
    highlights_dark.FloatTitle,
    blend_dark
  )
  table.insert(lines, "end")

  file:write(table.concat(lines, "\n"))
  file:flush()
  file:close()
end

local function write_lualine_colors()
  local file = io.open(
    vim.fn.stdpath "config" .. "/lua/lualine/themes/" .. THEME_NAME .. ".lua",
    "w"
  )
  if not file then
    vim.notify("Could not open lualine theme file.", vim.log.levels.WARN)
    return
  end

  local lines = {
    "-- This is a theme generated by color-tool.lua",
    "",
    "-- This replaces the default statusline highlight with the WinSeparator",
    "-- highlight. This is meant to be used to remove the differing, one character",
    "-- highlight on the right side of the statusline for windows on the bottom when",
    "-- lualine is in use.",
    'vim.api.nvim_set_hl(0, "StatusLine", { link = "WinSeparator" })',
    'vim.api.nvim_set_hl(0, "StatusLineNC", { link = "WinSeparator" })',
    "",
    "return " .. vim.inspect {
      normal = {
        a = "LualineA",
        b = "LualineB",
        c = "LualineC",
      },
      insert = {
        a = "LualineInsert",
      },
      replace = {
        a = "LualineReplace",
      },
      visual = {
        a = "LualineVisual",
      },
      command = {},
      inactive = {
        a = "LualineInactiveA",
      },
    },
  }

  file:write(table.concat(lines, "\n"))

  file:flush()
  file:close()
end

--- @param highlights_light table<string, vim.api.keyset.highlight>
--- @param highlights_dark table<string, vim.api.keyset.highlight>
local function write_fish_colors(highlights_light, highlights_dark)
  local file =
    io.open(vim.fn.stdpath "config" .. "/../fish/conf.d/1-theme.fish", "w")
  if not file then
    vim.notify("Could not open fish theme file.", vim.log.levels.WARN)
    return
  end

  --- @param color string
  --- @return string
  --- @return number
  local function convert_to_fish(color)
    return color:gsub("^#", "")
  end

  --- @param lines table<string>
  --- @param name string
  --- @param highlight vim.api.keyset.highlight
  --- @param omit_bg boolean|nil
  local function insert_highlight_line(lines, name, highlight, omit_bg)
    local line = "            set --universal fish_" .. name

    if highlight.fg then
      line = line .. " " .. convert_to_fish(highlight.fg)
    end

    if highlight.bg and not omit_bg then
      line = line .. " --background " .. convert_to_fish(highlight.bg)
    end

    if highlight.bold then
      line = line .. " --bold"
    end

    if highlight.italic then
      line = line .. " --italics"
    end

    if highlight.underline then
      line = line .. " --underline"
    end

    line = line .. " #"

    if highlight.fg then
      line = line .. " fg: " .. highlight.fg
    end

    if highlight.bg and not omit_bg then
      line = line .. " bg: " .. highlight.bg
    end

    table.insert(lines, line)
  end

  --- @param lines table<string>
  --- @param name string
  --- @param color string
  local function insert_color_line(lines, name, color)
    table.insert(
      lines,
      "            set --universal fish_"
        .. name
        .. " "
        .. convert_to_fish(color)
    )
  end

  --- @param lines table<string>
  --- @param name string
  --- @param string string
  local function insert_string_line(lines, name, string)
    table.insert(
      lines,
      "            set --universal fish_" .. name .. " " .. string
    )
  end

  --- @param lines table<string>
  --- @param highlights table<string, vim.api.keyset.highlight>
  local function insert_colors(lines, highlights)

    --stylua: ignore start
    insert_highlight_line(lines, "color_normal", highlights.Normal, true)
    insert_highlight_line(lines, "color_command", highlights.Function)
    insert_highlight_line(lines, "color_keyword", highlights.Statement)
    insert_highlight_line(lines, "color_quote", highlights.String)
    insert_highlight_line(lines, "color_redirection", highlights.Operator)
    insert_highlight_line(lines, "color_end", highlights.Special)
    insert_highlight_line(lines, "color_error", highlights.DiagnosticError)
    insert_highlight_line(lines, "color_param", highlights["@variable.parameter"])
    -- Not sure if I like this...
    -- insert_highlight_line(lines, "color_valid_path", highlights["@string.special.path"])
    -- insert_highlight_line(lines, "color_option", highlights["@variable.parameter"])
    insert_highlight_line(lines, "color_comment", highlights.Comment)
    insert_highlight_line(lines, "color_selection", highlights.Visual)
    insert_highlight_line(lines, "color_operator", highlights.Operator)
    insert_highlight_line(lines, "color_escape", highlights.SpecialChar)
    insert_highlight_line(lines, "color_autosuggestion", highlights.Comment)
    insert_highlight_line(lines, "color_cancel", highlights.SpecialKey)
    insert_highlight_line(lines, "color_search_match", highlights.Search)
    insert_highlight_line(lines, "color_history_current", highlights.Title)
    insert_highlight_line(lines, "pager_color_progress", highlights.MoreMsg)
    insert_highlight_line(lines, "pager_color_background", highlights.NormalFloat)
    insert_highlight_line(lines, "pager_color_prefix", highlights.SpecialChar, true)
    insert_highlight_line(lines, "pager_color_completion", highlights.Normal, true)
    insert_highlight_line(lines, "pager_color_description", highlights.Comment)
    insert_highlight_line(lines, "pager_color_selected_background", highlights.Visual)
    insert_color_line(lines, "prompt_color_mode_normal_fg", highlights.LualineA.fg)
    insert_color_line(lines, "prompt_color_mode_normal_bg", highlights.LualineA.bg)
    insert_string_line(lines, "prompt_color_mode_normal_bold", "--bold")
    insert_color_line(lines, "prompt_color_mode_insert_fg", highlights.LualineInsert.fg)
    insert_color_line(lines, "prompt_color_mode_insert_bg", highlights.LualineInsert.bg)
    insert_string_line(lines, "prompt_color_mode_insert_bold", "--bold")
    insert_color_line(lines, "prompt_color_mode_replace_fg", highlights.LualineReplace.fg)
    insert_color_line(lines, "prompt_color_mode_replace_bg", highlights.LualineReplace.bg)
    insert_string_line(lines, "prompt_color_mode_replace_bold", "--bold")
    insert_color_line(lines, "prompt_color_mode_visual_fg", highlights.LualineVisual.fg)
    insert_color_line(lines, "prompt_color_mode_visual_bg", highlights.LualineVisual.bg)
    insert_string_line(lines, "prompt_color_mode_visual_bold", "--bold")
    --stylua: ignore end
  end

  --- @param lines table<string>
  --- @param name string
  --- @param color string
  local function insert_cursor_color(lines, name, color)
    local line = "            set --universal fish_cursor_color_"
      .. name
      .. ' "\\e]12;rgb:'
      .. color:sub(2, 3)
      .. "/"
      .. color:sub(4, 5)
      .. "/"
      .. color:sub(6, 7)
      .. '\\e\\\\"'
      .. " # bg: "
      .. color

    table.insert(lines, line)
  end

  --- @param lines table<string>
  --- @param highlights table<string, vim.api.keyset.highlight>
  local function insert_cursor_colors(lines, highlights)
    insert_cursor_color(lines, "normal", highlights.Cursor.bg)
    insert_cursor_color(lines, "insert", highlights.CursorInsert.bg)
    insert_cursor_color(lines, "replace", highlights.CursorReplace.bg)
  end

  local lines = {
    "# This is a theme generated by ~/.config/nvim/lua/color-tool.lua",
    "",
    "function fish_handle_background_color_change \\",
    "    --description 'Handle changing the background color' \\",
    "    --on-variable fish_background_color",
    "",
    "    switch $fish_background_color",
    "        case light",
  }
  insert_colors(lines, highlights_light)
  insert_cursor_colors(lines, highlights_light)
  table.insert(lines, "")
  table.insert(lines, "        case '*'")
  insert_colors(lines, highlights_dark)
  insert_cursor_colors(lines, highlights_dark)
  table.insert(lines, "    end")
  table.insert(lines, "end")
  table.insert(lines, "")
  table.insert(lines, "function fish_vi_cursor_handle_color \\")
  table.insert(
    lines,
    "    --description 'Set the cursor color for the current mode.' \\"
  )
  table.insert(lines, "    --on-variable fish_bind_mode \\")
  table.insert(lines, "    --on-event fish_postexec \\")
  table.insert(lines, "    --on-event fish_focus_in")
  table.insert(lines, "")
  table.insert(lines, "    if not contains $fish_key_bindings \\")
  table.insert(
    lines,
    "            fish_vi_key_bindings fish_hybrid_key_bindings"
  )
  table.insert(lines, "")
  table.insert(lines, "        return")
  table.insert(lines, "    end")
  table.insert(lines, "")
  table.insert(lines, "    switch $fish_bind_mode")
  table.insert(lines, "        case insert")
  table.insert(lines, "            echo -en $fish_cursor_color_insert")
  table.insert(lines, "        case replace replace_one")
  table.insert(lines, "            echo -en $fish_cursor_color_replace")
  table.insert(lines, "        case '*'")
  table.insert(lines, "            echo -en $fish_cursor_color_normal")
  table.insert(lines, "    end")
  table.insert(lines, "end")
  table.insert(lines, "")
  table.insert(lines, "function fish_vi_cursor_handle_preexec_color \\")
  table.insert(
    lines,
    "    --description 'Set the cursor color for the neutral cursor.' \\"
  )
  table.insert(lines, "    --on-event fish_preexec")
  table.insert(lines, "")
  table.insert(lines, "    echo -en $fish_cursor_color_normal")
  table.insert(lines, "end")
  table.insert(lines, "")
  table.insert(lines, "fish_handle_background_color_change")
  table.insert(lines, "")
  table.insert(lines, "set fish_cursor_default block blink")
  table.insert(lines, "set fish_cursor_insert line blink")
  table.insert(lines, "set fish_cursor_replace underscore blink")
  table.insert(lines, "set fish_cursor_replace_one underscore blink")
  table.insert(lines, "set fish_cursor_visual block")

  file:write(table.concat(lines, "\n"))

  file:flush()
  file:close()
end

-- }}}

-- Hyper parameters {{{

local HUES = {
  pink = 0,
  red = 25,
  amber = 60,
  brown = 60,
  orange = 70,
  yellow = 90,
  green = 150,
  teal = 180,
  cyan = 195,
  seafoam = 220,
  blue = 240,
  azure = 256,
  grey = 270,
  purple = 300,
  magenta = 330,
}

--- SEMANTIC HUE VALUES
--- These are not just hue constants, but associations of semantic objects to
--- hues.
local H = {
  neutral = HUES.grey,
  interact = HUES.cyan,
  modified = HUES.purple,
  search = HUES.yellow,
  messages = HUES.green,
  modes = {
    insert = HUES.blue,
    replace = HUES.amber,
    visual = HUES.cyan,
  },
  diff = {
    add = HUES.green,
    change = HUES.orange,
    delete = HUES.red,
    text = HUES.amber,
  },
  diagnostics = {
    error = HUES.red,
    warn = HUES.orange,
    info = HUES.blue,
    hint = HUES.cyan,
    ok = HUES.green,
    debug = HUES.grey,
    trace = HUES.purple,
  },
  debug = {
    breakpoint = HUES.red,
    logpoint = HUES.yellow,
    current_frame = HUES.green,
  },
  spell = {
    bad = HUES.red,
    cap = HUES.yellow,
    loc = HUES.green,
    rare = HUES.cyan,
  },
  syntax = {
    boolean = HUES.orange,
    ["coroutine"] = HUES.yellow,
    directory = HUES.azure,
    doc_comment = HUES.blue,
    enum = HUES.blue,
    ["function"] = HUES.teal,
    identifier = HUES.green,
    literal = HUES.blue,
    member = HUES.blue,
    metaprogramming = HUES.purple,
    module = HUES.brown,
    number = HUES.blue,
    property = HUES.seafoam,
    special = HUES.red,
    statement = HUES.orange,
    storage_class = HUES.yellow,
    string = HUES.green,
    structure = HUES.green,
    typedef = HUES.green, -- FIXME: think of a better hue for typedef and types
    underlined = HUES.blue,
    variable = HUES.yellow - 10,
  },
}

--- The blend values for light and dark mode
local BLEND = {
  light = 20,
  dark = 20,
}

-- }}}

-- Palettes {{{

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
      visual      = convert(90,   5, H.interact),
    },
    statusline = {
      current = convert(70, 100, H.interact),
    },
    modes = {
      insert  = convert(50, 100, H.modes.insert),
      replace = convert(50, 100, H.modes.replace),
      visual  = convert(50, 100, H.modes.visual),
    },
  },

  search = {
    inc     = convert(85, 100, H.search),
    current = convert(90,   7, H.search),
    search  = convert(90,  10, H.search),
  },

  status = {
    modified = convert(50, 100, H.modified),
  },

  diff = {
    add = {
      light  = convert(90,   5, H.diff.add),
      strong = convert(50, 100, H.diff.add),
    },
    change = {
      light  = convert(89,  10, H.diff.change),
      strong = convert(50, 100, H.diff.change),
    },
    delete = {
      light  = convert(85,  10, H.diff.delete),
      strong = convert(50, 100, H.diff.delete),
    },
    text = {
      light = convert(85,  10, H.diff.text),
    },
  },

  diagnostics = {
    error = convert(50, 100, H.diagnostics.error),
    warn  = convert(50, 100, H.diagnostics.warn),
    info  = convert(50, 100, H.diagnostics.info),
    hint  = convert(50, 100, H.diagnostics.hint),
    ok    = convert(50, 100, H.diagnostics.ok),
    debug = convert(50,   0, H.diagnostics.debug),
    trace = convert(50, 100, H.diagnostics.trace),
  },

  debug = {
    breakpoint = {
      normal = convert(50, 100, H.debug.breakpoint),
      conditional = convert(50, 100, H.debug.breakpoint),
      log = convert(50, 100, H.debug.logpoint),
    },
    current_frame = convert(50, 100, H.debug.current_frame),
  },

  lsp = {
    reference = {
      text  = convert(90, 3, HUES.yellow),
      read  = convert(90, 3, HUES.green),
      write = convert(90, 3, HUES.blue),
    },
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
    boolean         = make_syn_with_bg(H.syntax.boolean),
    character       = make_syn_with_bg(H.syntax.string - 20),
    comment         = convert(60,   0, H.neutral),
    ["coroutine"]   = convert(70, 100, H.syntax["coroutine"]),
    directory       = convert(60, 100, H.syntax.directory),
    doc_comment     = convert(50,   5, H.syntax.doc_comment),
    enum            = convert(50, 100, H.syntax.enum),
    enum_member     = convert(50, 100, H.syntax.enum),
    event           = convert(50, 100, H.syntax["coroutine"]),
    float           = make_syn_with_bg(H.syntax.number + 20),
    ["function"]    = convert(50, 100, H.syntax["function"]),
    identifier      = convert(70,  10, H.syntax.identifier),
    literal         = make_syn_with_bg(nil),
    member          = convert(60, 100, H.syntax.member),
    metaprogramming = convert(60, 100, H.syntax.metaprogramming),
    module          = convert(30, 100, H.syntax.module),
    number          = make_syn_with_bg(H.syntax.number),
    parameter       = convert(70, 100, H.syntax.variable - 10),
    property        = convert(60, 100, H.syntax.property),
    special         = convert(55,  20, H.syntax.special),
    statement       = convert(70, 100, H.syntax.statement),
    storage_class   = convert(80, 100, H.syntax.storage_class),
    string          = make_syn_with_bg(H.syntax.string),
    structure       = convert(40, 100, H.syntax.structure),
    type            = convert(70, 100, H.syntax.typedef - 20),
    typedef         = convert(60, 100, H.syntax.typedef),
    underlined      = convert(50, 100, H.syntax.underlined),
    variable        = convert(70, 100, H.syntax.variable),
  },
}

-- }}}

-- Highlights setup {{{

local float_normal =
  { fg = palette.neutral.strongest, bg = palette.neutral.max }
local normal =
  { fg = palette.neutral.strongest, bg = modify_l(float_normal.bg, -5) }

local terminal_colors_light = {
  modify_l(normal.fg, 20),
  convert(60, 100, HUES.red),
  convert(60, 100, HUES.green),
  convert(60, 100, HUES.orange),
  convert(60, 100, HUES.blue),
  convert(60, 100, HUES.purple),
  convert(60, 100, HUES.teal),
  modify_l(normal.fg, 80),
}

vim.list_extend(
  terminal_colors_light,
  vim.tbl_map(function(c)
    return modify_l(c, -15, "chroma")
  end, terminal_colors_light)
)

--stylua: ignore
local framing = {
  --- @type table<string, vim.api.keyset.highlight>
  current = {
    normal = { fg = palette.neutral.lightest, bg = palette.interact.statusline.current, bold = true }
  },
  --- @type table<string, vim.api.keyset.highlight>
  neutral = {
    a       = { fg = normal.fg, bg = modify_l(normal.bg, -20) },
    b       = { fg = normal.fg, bg = modify_l(normal.bg, -10) },
    c       = { fg = normal.fg, bg = modify_l(normal.bg, -2.5) },
    c_no_fg = { fg = modify_l(normal.bg, -2.5), bg = modify_l(normal.bg, -2.5) },
  },
}

-- }}}}}}

-- Highlight definitions {{{

--stylua: ignore start

--- @type table<string, vim.api.keyset.highlight>
local highlights_light = {
  -- built-in *highlight-groups* {{{

  ColorColumn   = { bg = modify_l(normal.bg, -5) },
  Conceal       = { fg = palette.neutral.mid_strong },
  CurSearch     = { bg = palette.search.current },
  Cursor        = { bg = palette.interact.cursor.normal },
  lCursor       = { link = "Cursor" },
  CursorColumn  = { link = "CursorLine" },
  CursorLine    = { bg = palette.interact.cursor.markers },
  Directory     = { fg = palette.syntax.directory, bold = true },
  DiffAdd       = { bg = palette.diff.add.light },
  DiffChange    = { bg = palette.diff.change.light },
  DiffDelete    = { bg = palette.diff.delete.light },
  DiffText      = { bg = palette.diff.text.light, bold = true },
  TermCursor    = { link = "Cursor" },
  TermCursorNC  = { bg = palette.interact.cursor.non_current },
  ErrorMsg      = { fg = palette.diagnostics.error },
  WinSeparator  = framing.neutral.c_no_fg,
  Folded        = { fg = modify_l(normal.fg, 50), bg = modify_l(normal.bg, -5) },
  SignColumn    = { link = "LineNr" },
  IncSearch     = { bg = palette.search.inc },
  LineNr        = framing.neutral.b,
  LineNrAbove   = { fg = modify_l(framing.neutral.b.fg, 5), bg = modify_l(framing.neutral.b.bg, 5) },
  LineNrBelow   = { fg = modify_l(framing.neutral.b.fg, -5), bg = modify_l(framing.neutral.b.bg, -5) },
  CursorLineNr  = { fg = framing.neutral.b.fg, bg = palette.interact.cursor.markers },
  MatchParen    = { link = "CursorLine" },
  ModeMsg       = { fg = palette.messages.mode },
  MsgSeparator  = { link = "StatusLineNC" },
  MoreMsg       = { fg = palette.messages.more },
  NonText       = { fg = palette.neutral.light },
  Normal        = normal,
  NormalFloat   = { bg = palette.neutral.max },
  FloatTitle    = { bg = palette.neutral.max, bold = true },
  Pmenu         = { link = "NormalFloat" },
  PmenuSel      = { link = "CursorLine" },
  PmenuKindSel  = { link = "Pmenu" },
  PmenuExtraSel = { link = "Pmenu" },
  PmenuSbar     = { bg = palette.neutral.lighter_still },
  PmenuThumb    = { bg = palette.neutral.mid },
  Question      = { fg = palette.messages.more },
  QuickFixLine  = { link = "CursorLine" },
  Search        = { bg = palette.search.search },
  SpecialKey    = { fg = palette.neutral.strong, bg = palette.neutral.lighter, italic = true },
  SpellBad      = { undercurl = true, sp = palette.spell.bad },
  SpellCap      = { undercurl = true, sp = palette.spell.cap },
  SpellLocal    = { undercurl = true, sp = palette.spell.loc },
  SpellRare     = { undercurl = true, sp = palette.spell.rare },
  StatusLine    = framing.current.normal,
  StatusLineNC  = framing.neutral.a,
  TabLine       = { link = "LineNr" },
  TabLineFill   = { link = "StatusLineNC" },
  TabLineSel    = { link = "Normal" },
  Title         = { bold = true },
  Visual        = { bg = palette.interact.cursor.visual },
  WarningMsg    = { fg = palette.diagnostics.warn },
  WinBar        = { link = "StatusLine" },
  WinBarNC      = { link = "StatusLineNC" },

  -- }}}

  -- custom cursor highlight groups (see init.lua and *'guicursor'*) {{{

  CursorInsert  = { bg = palette.interact.modes.insert },
  CursorReplace = { bg = palette.interact.modes.replace },

  -- }}}

  -- diagnostics *diagnostic-highlights* {{{

  DiagnosticError = { fg = palette.diagnostics.error },
  DiagnosticWarn  = { fg = palette.diagnostics.warn },
  DiagnosticInfo  = { fg = palette.diagnostics.info },
  DiagnosticHint  = { fg = palette.diagnostics.hint },
  DiagnosticOk    = { fg = palette.diagnostics.ok },

  DiagnosticUnderlineError = { underline = true, sp = palette.diagnostics.error },
  DiagnosticUnderlineWarn  = { underline = true, sp = palette.diagnostics.warn },
  DiagnosticUnderlineInfo  = { underline = true, sp = palette.diagnostics.info },
  DiagnosticUnderlineHint  = { underline = true, sp = palette.diagnostics.hint },
  DiagnosticUnderlineOk    = { underline = true, sp = palette.diagnostics.ok },

  DiagnosticSignError = { fg = palette.diagnostics.error, bg = framing.neutral.b.bg },
  DiagnosticSignWarn  = { fg = palette.diagnostics.warn, bg = framing.neutral.b.bg },
  DiagnosticSignInfo  = { fg = palette.diagnostics.info, bg = framing.neutral.b.bg },
  DiagnosticSignHint  = { fg = palette.diagnostics.hint, bg = framing.neutral.b.bg },
  DiagnosticSignOk    = { fg = palette.diagnostics.ok, bg = framing.neutral.b.bg },

  DiagnosticDeprecated = { strikethrough = true, sp = palette.syntax.comment },

  -- }}}

  -- LSP highlights *lsp-highlight* {{{

  LspReferenceText  = { bg = palette.lsp.reference.text },
  LspReferenceRead  = { bg = palette.lsp.reference.read },
  LspReferenceWrite = { bg = palette.lsp.reference.write },

  LspInlayHint = { fg = palette.neutral.mid_light, bg = palette.neutral.lighter },

  LspCodeLens          = { link = "Comment" },
  LspCodeLensSeparator = { link = "LspCodeLens" },

  LspSignatureActiveParameter = { link = "Search" },

  -- }}}

  -- syntax groups *group-name* {{{

  Comment       = { fg = palette.syntax.comment },

  Constant      = palette.syntax.literal,
  String        = palette.syntax.string,
  Character     = palette.syntax.character,
  Number        = palette.syntax.number,
  Boolean       = palette.syntax.boolean,
  Float         = palette.syntax.float,

  Identifier    = { fg = palette.syntax.identifier },
  Function      = { fg = palette.syntax["function"], italic = false, nocombine = true },

  Statement     = { fg = palette.syntax.statement, bold = true },
  Operator      = { fg = palette.syntax.statement },

  PreProc       = { fg = palette.syntax.metaprogramming, bold = true },

  Type          = { fg = palette.syntax.type },
  StorageClass  = { fg = palette.syntax.storage_class },
  Structure     = { fg = palette.syntax.structure, italic = false, nocombine = true },
  Typedef       = { fg = palette.syntax.typedef, italic = false, nocombine = true },

  Special       = { fg = palette.syntax.special },
  SpecialChar   = { fg = palette.syntax.special, bg = palette.syntax.string.bg },
  Delimiter     = { link = "Special" },

  Underlined    = { fg = palette.syntax.underlined, underline = true, sp = palette.syntax.underlined },

  Error         = { fg = palette.neutral.max, bg = palette.diagnostics.error },

  Todo          = { bold = true },

  Added         = { fg = palette.diff.add.strong },
  Changed       = { fg = palette.diff.change.strong },
  Removed       = { fg = palette.diff.delete.strong },

  -- Syntax groups language overrides {{{

  -- razor {{{

  razorhtmlAttribute   = { link = "@tag.attribute" },
  razorhtmlTagName     = { link = "@tag" },
  razorcsIdentifier    = { link = "Identifier" },
  razorTypeIdentifier  = { link = "Structure" },
  razorUsingIdentifier = { link = "@module" },

  -- }}}}}}}}}

  -- command line expressions *expr-highlight* {{{

  -- TODO: implement

  -- }}}

  -- treesitter groups *treesitter-highlight-groups* {{{

  ["@variable"]                    = { fg = palette.syntax.variable, italic = true },
  ["@variable.builtin"]            = { fg = palette.syntax.special, italic = true },
  ["@variable.parameter"]          = { fg = palette.syntax.parameter, italic = true },
  ["@variable.member"]             = { fg = palette.syntax.member, italic = true },

  ["@constant"]                    = { fg = palette.syntax.variable, italic = false, nocombine = true },
  ["@constant.builtin"]            = { fg = palette.syntax.special, italic = false, nocombine = true },

  ["@module"]                      = { fg = palette.syntax.module, italic = false, nocombine = true },

  ["@string.documentation"]        = { fg = palette.syntax.doc_comment, bg = palette.syntax.string.bg },
  ["@string.regexp"]               = { link = "SpecialChar" },
  ["@string.escape"]               = { link = "SpecialChar" },
  ["@string.special"]              = { link = "SpecialChar" },
  ["@string.special.symbol"]       = { link = "SpecialChar" },
  ["@string.special.path"]         = { link = "SpecialChar" },

  ["@character"]                   = { link = "Character" },
  ["@character.special"]           = { fg = palette.syntax.special, bg = palette.syntax.character.bg },

  ["@boolean"]                     = { link = "Boolean" },
  ["@number"]                      = { link = "Number" },
  ["@number.float"]                = { link = "Float" },

  ["@type"]                        = { link = "Structure" },
  ["@type.builtin"]                = { link = "Type" },
  ["@type.definition"]             = { link = "Typedef" },

  ["@attribute"]                   = { fg = palette.syntax.metaprogramming, italic = false, nocombine = true },
  ["@property"]                    = { fg = palette.syntax.property, italic = true },

  ["@constructor"]                 = { link = "Function" },

  ["@keyword.coroutine"]           = { fg = palette.syntax["coroutine"], bold = true },
  ["@keyword.function"]            = { fg = palette.syntax["function"], bold = true },
  ["@keyword.operator"]            = { link = "Operator" },
  ["@keyword.import"]              = { fg = palette.syntax.module, bold = true },
  ["@keyword.repeat"]              = { link = "Repeat" },
  ["@keyword.exception"]           = { link = "Exception" },

  ["@keyword.conditional"]         = { link = "Conditional" },
  ["@keyword.conditional.ternary"] = { link = "Operator" },

  ["@keyword.directive"]           = { link = "PreProc" },
  ["@keyword.directive.define"]    = { link = "Define" },

  ["@comment.documentation"]       = { fg = palette.syntax.doc_comment },

  ["@markup.raw.block"]            = { fg = "NONE" },
  ["@markup.raw.markdown_inline"]  = { link = "Constant" },

  ["@tag"]                         = { fg = palette.syntax.statement, bold = true },
  ["@tag.attribute"]               = { link = "@property" },
  ["@tag.delimiter"]               = { link = "Delimiter" },

  -- Custom captures {{{

  ["@keyword.class"]     = { fg = palette.syntax.structure, bold = true },
  ["@keyword.interface"] = { fg = palette.syntax.metaprogramming, bold = true },
  ["@keyword.module"]    = { link = "@keyword.import" },

  -- }}}}}}

  -- LSP semantic highlight *lsp-semantic-highlight* {{{

  ["@lsp.type.comment"]    = { fg = "NONE" },
  ["@lsp.type.decorator"]  = { link = "@attribute" },
  ["@lsp.type.enum"]       = { fg = palette.syntax.number.fg }, -- TODO: check if it looks good
  ["@lsp.type.enumMember"] = { fg = palette.syntax.number.fg, italic = false, nocombine = true }, -- TODO: see above
  ["@lsp.type.fieldName"]  = { fg = palette.syntax.member },
  ["@lsp.type.interface"]  = { link = "@attribute" },
  ["@lsp.type.keyword"]    = { fg = "NONE" },
  ["@lsp.type.namespace"]  = { link = "@module" },
  ["@lsp.type.parameter"]  = { link = "@variable.parameter" },
  ["@lsp.type.property"]   = { link = "@property" },
  ["@lsp.type.variable"]   = { link = "@variable" },

  ["@lsp.mod.static"]   = { bold = true },
  ["@lsp.mod.readonly"] = { italic = false, nocombine = true },

  -- language overrides {{{

  -- C# {{{

  ["@lsp.type.macro.cs"] = { link = "PreProc" },

  -- }}}

  -- terraform-vars {{{

  ["@lsp.type.string.terraform-vars"] = { link = "String" },

  -- }}}}}}

  -- non-standard extensions {{{

  ["@lsp.type.constantName"] = { link = "@constant" },

  -- }}}}}}

  -- Plugins {{{

  -- gitsigns | https://github.com/lewis6991/gitsigns.nvim {{{

  GitSignsAdd    = { fg = palette.diff.add.strong, bg = framing.neutral.b.bg },
  GitSignsChange = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  GitSignsDelete = { fg = palette.diff.delete.strong, bg = framing.neutral.b.bg },

  -- }}}

  -- lazy.nvim | https://github.com/folke/lazy.nvim {{{

  -- These are only for backward-compatibility with Lazy. Lazy sometimes uses
  -- these directly, so there is no better way to set these.
  Bold   = { link = "@markup.strong" },
  Italic = { link = "@markup.italic" },

  LazyCommitScope   = { fg = palette.syntax.parameter, italic = true, nocombine = true },
  LazyCommitType    = { link = "@keyword"},
  LazyDir           = { link = "@markup.link" },
  LazyProgressDone  = { fg = framing.current.normal.bg, bg = framing.current.normal.bg },
  LazyProgressTodo  = framing.neutral.c_no_fg,
  LazyProp          = { fg = palette.syntax.property },
  LazyReasonCmd     = { link = "@function" },
  LazyReasonEvent   = { fg = palette.syntax["coroutine"] },
  LazyReasonFt      = { link = "@string" },
  LazyReasonImport  = { link = "@module" },
  LazyReasonInit    = { link = "@attribute" },
  LazyReasonKeys    = { link = "@operator" },
  LazyReasonPlugin  = { link = "@keyword.import" },
  LazyReasonRequire = { link = "DevIconLua" },
  LazyReasonRuntime = { link = "DevIconVim" },
  LazyReasonSource  = { link = "@character" },
  LazyReasonStart   = { link = "@keyword.directive" },
  LazyUrl           = { link = "@markup.link" },

  -- }}}

  -- lualine.nvim | https://github.com/nvim-lualine/lualine.nvim {{{

  LualineA               = framing.current.normal,
  LualineB               = framing.neutral.b,
  LualineC               = framing.neutral.c,
  LualineInactiveA       = framing.neutral.a,
  LualineInsert          = { fg = framing.current.normal.fg, bg = palette.interact.modes.insert, bold = true },
  LualineReplace         = { fg = framing.current.normal.fg, bg = palette.interact.modes.replace, bold = true },
  LualineVisual          = { fg = framing.current.normal.fg, bg = palette.interact.modes.visual, bold = true },
  LualineModified        = { fg = palette.status.modified, bg = framing.neutral.c.bg },
  LualineLazyPackages    = { fg = palette.syntax.module, bg = framing.neutral.c.bg },
  LualineDiagnosticError = { fg = palette.diagnostics.error, bg = framing.neutral.c.bg },
  LualineDiagnosticWarn  = { fg = palette.diagnostics.warn, bg = framing.neutral.c.bg },
  LualineDiagnosticInfo  = { fg = palette.diagnostics.info, bg = framing.neutral.c.bg },
  LualineDiagnosticHint  = { fg = palette.diagnostics.hint, bg = framing.neutral.c.bg },

  -- }}}

  -- mini.icons | https://github.com/echasnovski/mini.colors{{{

  MiniIconsAzure  = { fg = convert(60, 100, HUES.azure) },
  MiniIconsBlue   = { fg = convert(60, 100, HUES.blue) },
  MiniIconsCyan   = { fg = convert(60, 100, HUES.cyan) },
  MiniIconsGreen  = { fg = convert(60, 100, HUES.green) },
  MiniIconsGrey   = { fg = convert(60, 100, HUES.grey) },
  MiniIconsOrange = { fg = convert(60, 100, HUES.orange) },
  MiniIconsPurple = { fg = convert(60, 100, HUES.purple) },
  MiniIconsRed    = { fg = convert(60, 100, HUES.red) },
  MiniIconsYellow = { fg = convert(60, 100, HUES.yellow) },

  -- }}}

  -- nvim-cmp | https://github.com/hrsh7th/nvim-cmp {{{

  CmpItemAbbrDeprecated = { link = "DiagnosticDeprecated" },
  CmpItemAbbrMatch      = { bold = true },
  CmpItemAbbrMatchFuzzy = { link = "Character" },

  -- TODO: make the kind highlights dynamic.
  CmpItemKindArray         = { fg = palette.syntax.structure },
  CmpItemKindBoolean       = { fg = palette.syntax.boolean.fg },
  CmpItemKindClass         = { fg = palette.syntax.structure },
  CmpItemKindConstant      = { fg = palette.syntax.variable },
  CmpItemKindConstructor   = { fg = palette.syntax["function"] },
  CmpItemKindEnum          = { fg = palette.syntax.enum },
  CmpItemKindEnumMember    = { fg = palette.syntax.enum_member },
  CmpItemKindEvent         = { fg = palette.syntax.event },
  CmpItemKindField         = { fg = palette.syntax.member },
  CmpItemKindFile          = framing.neutral.c,
  CmpItemKindFunction      = { fg = palette.syntax["function"] },
  CmpItemKindInterface     = { fg = palette.syntax.metaprogramming },
  CmpItemKindKey           = { fg = palette.syntax.property },
  CmpItemKindMethod        = { fg = palette.syntax["function"] },
  CmpItemKindModule        = { fg = palette.syntax.module },
  CmpItemKindNamespace     = { fg = palette.syntax.module },
  CmpItemKindNull          = { fg = palette.syntax.literal.fg },
  CmpItemKindNumber        = { fg = palette.syntax.number.fg },
  CmpItemKindObject        = { fg = palette.syntax.structure },
  CmpItemKindOperator      = { fg = palette.syntax.statement },
  CmpItemKindPackage       = { fg = palette.syntax.module },
  CmpItemKindProperty      = { fg = palette.syntax.property },
  CmpItemKindString        = { fg = palette.syntax.string.fg },
  CmpItemKindStruct        = { fg = palette.syntax.structure },
  CmpItemKindTypeParameter = { fg = palette.syntax.structure },
  CmpItemKindVariable      = { fg = palette.syntax.variable, italic = true },

  -- }}}

  -- nvim-dap | https://github.com/mfussenegger/nvim-dap {{{

  DapBreakpoint          = { fg = palette.debug.breakpoint.normal, bg = framing.neutral.b.bg },
  DapBreakpointCondition = { fg = palette.debug.breakpoint.conditional, bg = framing.neutral.b.bg },
  DapLogPoint            = { fg = palette.debug.breakpoint.log, bg = framing.neutral.b.bg },
  DapStopped             = { fg = palette.debug.current_frame, bg = framing.neutral.b.bg },
  DapBreakpointRejected  = { bg = framing.neutral.b.bg },

  -- }}}

  -- nvim-navic | https://github.com/SmiteshP/nvim-navic {{{

  NavicIconsArray         = { fg = palette.syntax.structure, bg = framing.neutral.c.bg },
  NavicIconsBoolean       = { fg = palette.syntax.boolean.fg, bg = framing.neutral.c.bg },
  NavicIconsClass         = { fg = palette.syntax.structure, bg = framing.neutral.c.bg },
  NavicIconsConstant      = { fg = palette.syntax.variable, bg = framing.neutral.c.bg },
  NavicIconsConstructor   = { fg = palette.syntax["function"], bg = framing.neutral.c.bg },
  NavicIconsEnum          = { fg = palette.syntax.enum, bg = framing.neutral.c.bg },
  NavicIconsEnumMember    = { fg = palette.syntax.enum_member, bg = framing.neutral.c.bg },
  NavicIconsEvent         = { fg = palette.syntax.event, bg = framing.neutral.c.bg },
  NavicIconsField         = { fg = palette.syntax.member, bg = framing.neutral.c.bg },
  NavicIconsFile          = framing.neutral.c,
  NavicIconsFunction      = { fg = palette.syntax["function"], bg = framing.neutral.c.bg },
  NavicIconsInterface     = { fg = palette.syntax.metaprogramming, bg = framing.neutral.c.bg },
  NavicIconsKey           = { fg = palette.syntax.property, bg = framing.neutral.c.bg },
  NavicIconsMethod        = { fg = palette.syntax["function"], bg = framing.neutral.c.bg },
  NavicIconsModule        = { fg = palette.syntax.module, bg = framing.neutral.c.bg },
  NavicIconsNamespace     = { fg = palette.syntax.module, bg = framing.neutral.c.bg },
  NavicIconsNull          = { fg = palette.syntax.literal.fg, bg = framing.neutral.c.bg },
  NavicIconsNumber        = { fg = palette.syntax.number.fg, bg = framing.neutral.c.bg },
  NavicIconsObject        = { fg = palette.syntax.structure, bg = framing.neutral.c.bg },
  NavicIconsOperator      = { fg = palette.syntax.statement, bg = framing.neutral.c.bg },
  NavicIconsPackage       = { fg = palette.syntax.module, bg = framing.neutral.c.bg },
  NavicIconsProperty      = { fg = palette.syntax.property, bg = framing.neutral.c.bg },
  NavicIconsString        = { fg = palette.syntax.string.fg, bg = framing.neutral.c.bg },
  NavicIconsStruct        = { fg = palette.syntax.structure, bg = framing.neutral.c.bg },
  -- NavicIconsTypeParameter = { fg = palette.syntax.structure, bg = framing.neutral.c.bg },
  NavicIconsVariable      = { fg = palette.syntax.variable, bg = framing.neutral.c.bg, italic = true },
  NavicSeparator          = framing.neutral.c,
  NavicText               = framing.neutral.c,

  -- }}}

  -- nvim-notify | https://github.com/rcarriga/nvim-notify {{{

  NotifyDEBUGBorder = { fg = palette.diagnostics.debug },
  NotifyDEBUGIcon   = { fg = palette.diagnostics.debug },
  NotifyDEBUGTitle  = { fg = palette.diagnostics.debug },
  NotifyERRORBorder = { link = "DiagnosticError" },
  NotifyERRORIcon   = { link = "DiagnosticError" },
  NotifyERRORTitle  = { link = "DiagnosticError" },
  NotifyINFOBorder  = { link = "DiagnosticInfo" },
  NotifyINFOIcon    = { link = "DiagnosticInfo" },
  NotifyINFOTitle   = { link = "DiagnosticInfo" },
  NotifyTRACEBorder = { fg = palette.diagnostics.trace },
  NotifyTRACEIcon   = { fg = palette.diagnostics.trace },
  NotifyTRACETitle  = { fg = palette.diagnostics.trace },
  NotifyWARNBorder  = { link = "DiagnosticWarn" },
  NotifyWARNIcon    = { link = "DiagnosticWarn" },
  NotifyWARNTitle   = { link = "DiagnosticWarn" },

  -- }}}

  -- oil-git-status | https://github.com/refractalize/oil-git-status.nvim {{{

  OilGitStatusIndexUnmodified        = framing.neutral.b,
  OilGitStatusIndexIgnored           = framing.neutral.b,
  OilGitStatusIndexUntracked         = { fg = palette.diff.add.strong, bg = framing.neutral.b.bg },
  OilGitStatusIndexAdded             = { fg = palette.diff.add.strong, bg = framing.neutral.b.bg },
  OilGitStatusIndexCopied            = { fg = palette.diff.add.strong, bg = framing.neutral.b.bg },
  OilGitStatusIndexDeleted           = { fg = palette.diff.delete.strong, bg = framing.neutral.b.bg },
  OilGitStatusIndexModified          = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  OilGitStatusIndexRenamed           = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  OilGitStatusIndexTypeChanged       = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  OilGitStatusIndexUnmerged          = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  OilGitStatusWorkingTreeUnmodified  = framing.neutral.b,
  OilGitStatusWorkingTreeIgnored     = framing.neutral.b,
  OilGitStatusWorkingTreeUntracked   = { fg = palette.diff.add.strong, bg = framing.neutral.b.bg },
  OilGitStatusWorkingTreeAdded       = { fg = palette.diff.add.strong, bg = framing.neutral.b.bg },
  OilGitStatusWorkingTreeCopied      = { fg = palette.diff.add.strong, bg = framing.neutral.b.bg },
  OilGitStatusWorkingTreeDeleted     = { fg = palette.diff.delete.strong, bg = framing.neutral.b.bg },
  OilGitStatusWorkingTreeModified    = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  OilGitStatusWorkingTreeRenamed     = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  OilGitStatusWorkingTreeTypeChanged = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  OilGitStatusWorkingTreeUnmerged    = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },

  -- }}}

  -- vim-illuminate | https://github.com/RRethy/vim-illuminate {{{

  IlluminatedWordText  = { link = "LspReferenceText" },
  IlluminatedWordRead  = { link = "LspReferenceRead" },
  IlluminatedWordWrite = { link = "LspReferenceWrite" },

  -- }}}}}}
}

-- Dark mode overrides {{{

--- @type table<string, vim.api.keyset.highlight>
local highlights_dark_overrides = {
  Cursor    = { bg = palette.interact.cursor.normal },
  IncSearch = { bg = invert_l(highlights_light.IncSearch.bg, "cusp") },
}

-- }}}

--stylua: ignore end

-- }}}

-- Automation {{{

--- @type table<string, vim.api.keyset.highlight>
local highlights_dark = vim.tbl_extend(
  "force",
  vim.tbl_map(map_hl_to_dark, highlights_light),
  highlights_dark_overrides
)

--- @type table<string, vim.api.keyset.highlight>
local terminal_colors_dark = vim.tbl_map(function(c)
  return modify_l(invert_l(c), 10)
end, terminal_colors_light)

add_cterm_values(highlights_light)
add_cterm_values(highlights_dark)

if SHOW_PREVIEW_BUFFER then
  create_preview_buffer(
    highlights_light,
    highlights_dark,
    terminal_colors_light,
    terminal_colors_dark
  )
end

if WRITE_COLORSCHEME then
  write_nvim_colors(
    highlights_light,
    highlights_dark,
    terminal_colors_light,
    terminal_colors_dark,
    BLEND.light,
    BLEND.dark
  )
  write_lualine_colors()
  write_fish_colors(highlights_light, highlights_dark)
end

-- }}}
