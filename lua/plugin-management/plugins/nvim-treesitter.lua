-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "LiadOz/nvim-dap-repl-highlights",
  },
  lazy = false,
  -- TODO: migrate to "main"
  branch = "master",
  build = function()
    pcall(vim.cmd, "TSUpdate")
  end,
  config = function()
    local has_dap_repl_hl, dap_repl_hl =
      pcall(require, "nvim-dap-repl-highlights")
    if not has_dap_repl_hl then
      return
    end

    local has_configs, configs = pcall(require, "nvim-treesitter.configs")
    if not has_configs then
      return
    end

    dap_repl_hl.setup()

    ---@diagnostic disable-next-line: missing-fields
    configs.setup {
      ensure_installed = {
        -- This should only include languages that are not automatically
        -- installed, most often because they are injected.
        "comment",
        "dap_repl",
        "diff", -- injected in git commit
        "luadoc",
        "markdown",
        "markdown_inline",
        "mermaid",
        "printf",
        "regex",
      },
      auto_install = true,

      -- modules below

      -- RRethy/nvim-treesitter-endwise
      -- FIXME: This doesn't work with nvim-treesitter main branch
      -- https://github.com/RRethy/nvim-treesitter-endwise/issues/27
      endwise = {
        enable = true,
      },

      -- nvim-treesitter/nvim-treesitter
      highlight = {
        enable = true,
      },

      -- nvim-treesitter/nvim-treesitter
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<Tab>",
          scope_incremental = "<CR>",
          node_decremental = "<S-Tab>",
        },
      },

      -- nvim-treesitter/nvim-treesitter
      indent = {
        enable = true,
      },

      -- andymass/vim-matchup
      -- FIXME: This doesn't work with nvim-treesitter main branch
      matchup = {
        enable = true,
      },

      -- nvim-treesitter/nvim-treesitter-textobjects
      -- FIXME: This doesn't work with nvim-treesitter main branch
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = {
              query = "@function.outer",
              desc = "treesitter-textobjects: Next function start",
            },
            ["]]"] = {
              query = "@class.outer",
              desc = "treesitter-textobjects: Next class start",
            },
          },
          goto_next_end = {
            ["]M"] = {
              query = "@function.outer",
              desc = "treesitter-textobjects: Next function end",
            },
            ["]["] = {
              query = "@class.outer",
              desc = "treesitter-textobjects: Next class end",
            },
          },
          goto_previous_start = {
            ["[m"] = {
              query = "@function.outer",
              desc = "treesitter-textobjects: Previous function start",
            },
            ["[["] = {
              query = "@class.outer",
              desc = "treesitter-textobjects: Previous class start",
            },
          },
          goto_previous_end = {
            ["[M"] = {
              query = "@function.outer",
              desc = "treesitter-textobjects: Previous function end",
            },
            ["[]"] = {
              query = "@class.outer",
              desc = "treesitter-textobjects: Previous class end",
            },
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            am = {
              query = "@function.outer",
              desc = "treesitter-textobjects: Select outer function",
            },
            ["im"] = {
              query = "@function.inner",
              desc = "treesitter-textobjects: Select inner function",
            },
            ac = {
              query = "@class.outer",
              desc = "treesitter-textobjects: Select outer class",
            },
            ic = {
              query = "@class.inner",
              desc = "treesitter-textobjects: Select inner class",
            },
          },
        },
      },
    }
  end,
}
