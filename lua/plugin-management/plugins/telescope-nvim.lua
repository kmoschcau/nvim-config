--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "folke/noice.nvim",
    "gbrlsnchs/telescope-lsp-handlers.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "piersolenski/telescope-import.nvim",
    "rcarriga/nvim-notify",
  },
  keys = {
    {
      "<C-p>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Telescope: Open file search.",
    },
    {
      vim.fn.has "mac" == 1 and "<C-/>" or "<C-_>",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Telescope: Open live grep search.",
    },
    {
      "<Space>gg",
      function()
        require("telescope.builtin").git_commits()
      end,
      desc = "Telescope: List git commits of current directory.",
    },
    {
      "<Space>gb",
      function()
        require("telescope.builtin").git_bcommits()
      end,
      desc = "Telescope: List git commits of current buffer.",
    },
    {
      "<Space>t",
      function()
        require("telescope.builtin").diagnostics { bufnr = 0 }
      end,
      desc = "Telescope: Fuzzy search diagnostics in current buffer.",
    },
    {
      "<Space>T",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Telescope: Fuzzy search diagnostics in workspace.",
    },
  },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    local lsp_common_opts = {
      fname_width = 0.5,
    }

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-S>"] = actions.select_horizontal,
            ["<C-X>"] = false,
          },
          n = {
            ["<C-S>"] = actions.select_horizontal,
            ["<C-X>"] = false,
          },
        },
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
        live_grep = vim.tbl_extend("force", lsp_common_opts, {
          mappings = {
            i = {
              ["<C-f>"] = actions.to_fuzzy_refine,
            },
          },
        }),
        lsp_references = vim.tbl_extend("force", lsp_common_opts, {
          include_declaration = false,
        }),
        lsp_incoming_calls = lsp_common_opts,
        lsp_outgoing_calls = lsp_common_opts,
        lsp_definitions = lsp_common_opts,
        lsp_type_definitions = lsp_common_opts,
        lsp_implementations = lsp_common_opts,
        lsp_workspace_symbols = lsp_common_opts,
      },
    }

    telescope.load_extension "fzf"
    telescope.load_extension "import"
    telescope.load_extension "noice"
    telescope.load_extension "notify"
    telescope.load_extension "lsp_handlers"
  end,
}
