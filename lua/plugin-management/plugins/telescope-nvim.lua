return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  keys = {
    {
      "<C-p>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Open telescope file search.",
      silent = true,
    },
    {
      "<C-_>",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Open telescope live grep search.",
      silent = true,
    },
    {
      "<space>t",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Fuzzy search diagnostics.",
      silent = true,
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
            ["<c-x>"] = false,
            ["<c-s>"] = actions.select_horizontal,
          },
          n = {
            ["<c-x>"] = false,
            ["<c-s>"] = actions.select_horizontal,
          },
        },
      },
      pickers = {
        live_grep = vim.tbl_extend("force", lsp_common_opts, {
          mappings = {
            i = {
              ["<c-f>"] = actions.to_fuzzy_refine,
            },
          },
        }),
        lsp_references = lsp_common_opts,
        lsp_incoming_calls = lsp_common_opts,
        lsp_outgoing_calls = lsp_common_opts,
        lsp_definitions = lsp_common_opts,
        lsp_type_definitions = lsp_common_opts,
        lsp_implementations = lsp_common_opts,
        lsp_workspace_symbols = lsp_common_opts,
      },
    }

    require("telescope").load_extension "fzf"
    require("telescope").load_extension "notify"
  end,
}
