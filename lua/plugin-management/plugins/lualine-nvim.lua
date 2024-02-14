local symbols = require "symbols"
local separators = symbols.separators

--- @type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local vcs_shorten_width = 200
    local vcs_display_width = 120

    local navic_component = {
      "navic",
      fmt = function(text)
        return string.gsub(text, "%%%*$", "")
      end,
    }

    local win_number_component = {
      function()
        return vim.api.nvim_win_get_number(0)
      end,
      separator = { left = separators.section.top.right },
    }

    local lualine_c = {
      {
        "filename",
        path = 1, -- relative path
        newfile_status = true,
        symbols = symbols.files,
        color = function()
          return vim.bo.modified and "LualineModified" or "LualineC"
        end,
      },
    }

    local lualine_x = {
      {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = "LualineLazyPackages",
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        -- sections = { severity },
        separator = { left = separators.section.bottom.right, right = "" },
        diagnostics_color = {
          error = "DiagnosticSignError",
          warn = "DiagnosticSignWarn",
          info = "DiagnosticSignInfo",
          hint = "DiagnosticSignHint",
        },
        symbols = symbols.diagnostics.severities,
      },
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
        theme = vim.g.colors_name,
        component_separators = separators.component.bottom,
        section_separators = separators.section.bottom,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "diff",
            colored = true,
            symbols = symbols.git.lines,
            separator = { left = "", right = separators.section.bottom.left },
            cond = function()
              return vim.fn.winwidth(0) > vcs_display_width
            end,
            source = function()
              --- @type Gitsigns.StatusObj
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
