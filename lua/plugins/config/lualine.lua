local max_count = 99

local vcs_shorten_width = 200
local vcs_display_width = 120
local ws_shorten_width = 200

local function count_search(pattern)
  local count_tbl = vim.fn.searchcount({
    pattern = pattern,
    maxcount = max_count,
    pos = { 1, 1, 0 }
  })

  if count_tbl.total < 1 then return false end

  count_tbl.first = vim.fn.search(pattern, "nwc")

  return count_tbl
end

local function mixed_indent_file()
  local tab_indent_info = count_search [[\v^\t+]]
  if not tab_indent_info then return false end

  local space_indent_info = count_search [[\v^ +]]
  if not space_indent_info then return false end

  if tab_indent_info.total > space_indent_info.total then
    space_indent_info.label = "space"
    return space_indent_info
  else
    tab_indent_info.label = "tab"
    return tab_indent_info
  end
end

local function format_count_search(count_search_info, label)
  if count_search_info.total < 1 then return "" end

  local count = count_search_info.total > max_count
      and string.format("(%d+)", max_count)
      or tostring(count_search_info.total)

  return string.format("%s*%s[%d]", count, label, count_search_info.first)
end

local function format_trailing(info)
  return format_count_search(
    info, vim.fn.winwidth(0) > ws_shorten_width and "trailing" or "TR")
end

local function format_mixed_indent_line(info)
  return format_count_search(
    info, vim.fn.winwidth(0) > ws_shorten_width and "mixed-indent-line" or "ML")
end

local function format_mixed_indent_file(info)
  return format_count_search(
    info,
    vim.fn.winwidth(0) > ws_shorten_width
    and string.format("mixed-indent-file(%s)", info.label)
    or string.format("MF(%s)", info.label:sub(1, 1)))
end

local function whitespace_checks()
  local trailing_info = count_search [[\v\s+$]]
  local mixed_indent_line_info = count_search [[\v^ +\t]]
  local mixed_indent_file_info = mixed_indent_file()

  if not trailing_info and
      not mixed_indent_line_info and
      not mixed_indent_file_info then return "" end

  local result = "☲"
  result = result ..
      (trailing_info and " " .. format_trailing(trailing_info) or "")
  result = result ..
      (mixed_indent_line_info
          and " " .. format_mixed_indent_line(mixed_indent_line_info)
          or "")
  result = result ..
      (mixed_indent_file_info
          and " " .. format_mixed_indent_file(mixed_indent_file_info)
          or "")
  return result
end

local function create_diagnostics_section(severity)
  return {
    "diagnostics",
    sources = { "nvim_lsp", "nvim_diagnostic", "ale" },
    sections = { severity },
    separator = { left = "", right = "" },
    diagnostics_color = {
      error = "DiagnosticError",
      warn = "DiagnosticWarn",
      info = "DiagnosticInfo",
      hint = "DiagnosticHint"
    },
    symbols = require("icons")
  }
end

local lualine_c = {
  {
    "filename",
    color = function()
      return vim.bo.modified
          and "Material_LualineModified"
          or "Material_Lualine3"
    end,
    path = 1 -- relative path
  }
}

local lualine_x = {
  "filetype",
  {
    whitespace_checks,
    color = "Material_VimWarningInverted",
    separator = { left = "", right = "" },
  },
  create_diagnostics_section("hint"),
  create_diagnostics_section("info"),
  create_diagnostics_section("warn"),
  create_diagnostics_section("error")
}

local lualine_y = {
  {
    "encoding",
    padding = { left = 1, right = 0 },
    separator = ""
  },
  {
    "fileformat",
    separator = ""
  }
}

local lualine_z = {
  "%3p%% :%l/%L☰ ℅:%c",
  function() return vim.api.nvim_win_get_number(0) end
}

require("lualine").setup {
  options = {
    theme = "material"
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "diff",
        colored = false,
        padding = { left = 1, right = 0 },
        separator = "",
        cond = function() return vim.fn.winwidth(0) > vcs_display_width end
      },
      {
        "branch",
        separator = "",
        cond = function() return vim.fn.winwidth(0) > vcs_display_width end,
        fmt = function(str)
          if vim.fn.winwidth(0) > vcs_shorten_width then return str end

          local parts = vim.split(str, "/", { plain = true, trimempty = true })
          if #parts == 0 then return "" end

          return parts[#parts]:sub(1, 15) .. "…"
        end
      }
    },
    lualine_c = lualine_c,
    lualine_x = lualine_x,
    lualine_y = lualine_y,
    lualine_z = lualine_z
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = lualine_c,
    lualine_x = lualine_x,
    lualine_y = lualine_y,
    lualine_z = lualine_z
  },
  extensions = {
    "fugitive",
    "nvim-tree",
    "quickfix"
  }
}
