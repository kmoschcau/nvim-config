-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "piersolenski/telescope-import.nvim",
    "rcarriga/nvim-notify",
  },
  keys = {
    {
      "<Space>tf",
      require("telescope.builtin").find_files,
      desc = "Telescope: Open file search.",
    },
    {
      "<Space>tF",
      function()
        require("telescope.builtin").find_files {
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
        }
      end,
      desc = "Telescope: Open file search without ignoring files.",
    },
    {
      "<Space>tr",
      require("telescope.builtin").live_grep,
      desc = "Telescope: Open live grep search.",
    },
    {
      "<Space>tgc",
      require("telescope.builtin").git_commits,
      desc = "Telescope: List git commits of current directory.",
    },
    {
      "<Space>tgb",
      require("telescope.builtin").git_bcommits,
      desc = "Telescope: List git commits of current buffer.",
    },
    {
      "<Space>t=",
      require("telescope.builtin").spell_suggest,
      desc = "Telescope: List spelling suggestions for the current word.",
    },
  },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    local default_picker_settings = { theme = "ivy" }

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-S>"] = actions.select_horizontal,
            ["<C-X>"] = false,
          },
          n = {
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-S>"] = actions.select_horizontal,
            ["<C-X>"] = false,
          },
        },
        path_display = { "smart" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--engine=auto",
        },
      },
      pickers = {
        find_files = default_picker_settings,
        git_commits = default_picker_settings,
        git_bcommits = default_picker_settings,
        live_grep = vim.tbl_extend("force", default_picker_settings, {
          mappings = {
            i = {
              ["<C-f>"] = actions.to_fuzzy_refine,
            },
          },
        }),
        lsp_definitions = default_picker_settings,
        lsp_implementations = default_picker_settings,
        lsp_type_definitions = default_picker_settings,
        lsp_references = vim.tbl_extend("force", default_picker_settings, {
          include_declaration = false,
        }),
        lsp_incoming_calls = default_picker_settings,
        lsp_outgoing_calls = default_picker_settings,
        lsp_document_symbols = default_picker_settings,
        lsp_workspace_symbols = default_picker_settings,
      },
      extensions = {
        import = {
          insert_at_top = true,
        },
      },
    }

    telescope.load_extension "fzf"
    telescope.load_extension "import"
    telescope.load_extension "notify"
    telescope.load_extension "rest"
  end,
}
