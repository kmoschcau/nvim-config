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
    local lualine_b = {
      {
        "diff",
        colored = true,
        symbols = symbols.git.lines,
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
        fmt = function(str)
          if vim.fn.winwidth(0) > 200 then
            return str
          end
          if #str <= 15 then
            return str
          end

          local parts = vim.split(str, "/", { plain = true, trimempty = true })
          if #parts == 0 then
            return ""
          end

          return parts[#parts]:sub(1, 15) .. "…"
        end,
      },
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

    local lualine_x = {}

    local has_lazy, lazy_status = pcall(require, "lazy.status")
    if has_lazy then
      table.insert(lualine_x, {
        lazy_status.updates,
        cond = lazy_status.has_updates,
        color = "LualineLazyPackages",
        on_click = function()
          vim.cmd.Lazy()
        end,
      })
    end

    table.insert(lualine_x, {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      diagnostics_color = {
        error = "LualineDiagnosticError",
        warn = "LualineDiagnosticWarn",
        info = "LualineDiagnosticInfo",
        hint = "LualineDiagnosticHint",
      },
      symbols = symbols.diagnostics.severities,
      on_click = function()
        local has_telescope, telescope = pcall(require, "telescope.builtin")
        if has_telescope then
          telescope.diagnostics { bufnr = 0 }
        end
      end
    })

    local lualine_y = {
      { "filetype" },
      { "encoding" },
      { "fileformat" },
    }

    local lualine_z = {
      "%3p%% :%l/%L :%5(%c%V%)",
    }

    require("lualine").setup {
      options = {
        theme = vim.g.colors_name,
        component_separators = separators.component.bottom,
        section_separators = separators.section.bottom,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = lualine_b,
        lualine_c = lualine_c,
        lualine_x = lualine_x,
        lualine_y = lualine_y,
        lualine_z = lualine_z,
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = lualine_b,
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
