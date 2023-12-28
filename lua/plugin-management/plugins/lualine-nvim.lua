local symbols = require "symbols"
local separators = symbols.separators

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local vcs_shorten_width = 200
    local vcs_display_width = 120

    local function create_diagnostics_component(severity)
      return {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { severity },
        separator = { left = separators.level1.right, right = "" },
        diagnostics_color = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
        },
        symbols = symbols.diagnostics.severities,
      }
    end

    local navic_component = {
      "navic",
      fmt = function(text)
        return string.gsub(text, "%%%*$", "")
      end,
    }

    local win_number_component = function()
      return vim.api.nvim_win_get_number(0)
    end

    local lualine_c = {
      {
        "filename",
        path = 1, -- relative path
        newfile_status = true,
        symbols = symbols.files,
        color = function()
          return vim.bo.modified and "Material_LualineModified"
            or "Material_Lualine3"
        end,
      },
    }

    local lualine_x = {
      {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = "Material_LualineLazyPackages",
      },
      create_diagnostics_component "hint",
      create_diagnostics_component "info",
      create_diagnostics_component "warn",
      create_diagnostics_component "error",
    }

    local lualine_y = {
      {
        "filetype",
        padding = { left = 1, right = 0 },
      },
      {
        "encoding",
        padding = 0,
      },
      {
        "fileformat",
        padding = { left = 0, right = 1 },
      },
    }

    local lualine_z = {
      "%3p%% :%l/%L :%c",
    }

    require("lualine").setup {
      options = {
        theme = "material",
        component_separators = separators.level2,
        section_separators = separators.level1,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "diff",
            colored = true,
            diff_color = {
              added = "Material_VimDiffSignAdd",
              modified = "Material_VimDiffSignChange",
              removed = "Material_VimDiffSignDelete",
            },
            symbols = symbols.git.lines,
            separator = { left = "", right = separators.level1.left },
            cond = function()
              return vim.fn.winwidth(0) > vcs_display_width
            end,
            source = function()
              --- @diagnostic disable-next-line: undefined-field
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          {
            "branch",
            separator = "",
            cond = function()
              return vim.fn.winwidth(0) > vcs_display_width
            end,
            fmt = function(str)
              if vim.fn.winwidth(0) > vcs_shorten_width then
                return str
              end
              if #str <= 15 then
                return str
              end

              local parts =
                vim.split(str, "/", { plain = true, trimempty = true })
              if #parts == 0 then
                return ""
              end

              return parts[#parts]:sub(1, 15) .. "…"
            end,
          },
        },
        lualine_c = lualine_c,
        lualine_x = lualine_x,
        lualine_y = lualine_y,
        lualine_z = lualine_z,
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = lualine_c,
        lualine_x = lualine_x,
        lualine_y = lualine_y,
        lualine_z = lualine_z,
      },
      winbar = {
        lualine_c = {
          navic_component,
        },
        lualine_z = {
          win_number_component,
        },
      },
      inactive_winbar = {
        lualine_c = {
          navic_component,
        },
        lualine_z = {
          win_number_component,
        },
      },
      extensions = {
        "fugitive",
        "neo-tree",
        "nvim-dap-ui",
        "mason",
        "oil",
        "quickfix",
      },
    }
  end,
}
