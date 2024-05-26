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
      desc = "Open telescope file search.",
    },
    {
      vim.fn.has "mac" == 1 and "<C-/>" or "<C-_>",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Open telescope live grep search.",
    },
    {
      "<Space>t",
      function()
        require("telescope.builtin").diagnostics { bufnr = 0 }
      end,
      desc = "Fuzzy search diagnostics in current buffer.",
    },
    {
      "<Space>T",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Fuzzy search diagnostics in workspace.",
    },
  },
  config = function()
    local actions = require "telescope.actions"

    local lsp_common_opts = {
      fname_width = 0.5,
    }

    require("telescope").setup {
      defaults = {
        mappings = {
          i = {
            ["<C-x>"] = false,
            ["<C-s>"] = actions.select_horizontal,
          },
          n = {
            ["<C-x>"] = false,
            ["<C-s>"] = actions.select_horizontal,
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

    require("telescope").load_extension "fzf"
    require("telescope").load_extension "import"
    require("telescope").load_extension "noice"
    require("telescope").load_extension "notify"
    require("telescope").load_extension "lsp_handlers"
  end,
}
