local symbols = require "symbols"
local separators = symbols.separators

-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "echasnovski/mini.nvim",
  },
  config = function()
    local navic_component = {
      "navic",
      fmt = function(text)
        return string.gsub(text, "%%%*$", "")
      end,
    }

    local oil_pwd_component = {
      function()
        local dir = require("oil").get_current_dir()
        if dir then
          return vim.fn.fnamemodify(dir, ":~")
        else
          return ""
        end
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
          local min_trim_width = 200
          local max_trimmed_width = 15
          local split_char = "/"
          local ellipsis = "…"
          local ellipsis_width = 1

          if vim.fn.winwidth(0) > min_trim_width then
            return str
          end

          if #str <= max_trimmed_width then
            return str
          end

          local parts =
            vim.split(str, split_char, { plain = true, trimempty = true })
          if #parts == 0 then
            return ""
          end

          local max_text_width = max_trimmed_width
          local result = parts[#parts]
          if #parts > 1 then
            result = ellipsis .. split_char .. result
            max_text_width = max_text_width - ellipsis_width - #split_char
          end

          if #result <= max_trimmed_width then
            return result
          end

          return result:sub(1, max_text_width - ellipsis_width) .. ellipsis
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

    local lualine_x = {
      { "rest" },
    }

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
      end,
    })

    local lualine_y = {
      { "filetype" },
      { "encoding", show_bomb = true },
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
          oil_pwd_component,
          navic_component,
        },
        lualine_z = {
          win_number_component,
        },
      },
      inactive_winbar = {
        lualine_c = {
          oil_pwd_component,
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
        "trouble",
      },
    }
  end,
}
