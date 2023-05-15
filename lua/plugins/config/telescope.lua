local lsp_common_opts = {
  fname_width = 0.5,
  trim_text = true,
}

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-s>"] = "select_horizontal",
      },
      n = {
        ["<C-x>"] = false,
        ["<C-s>"] = "select_horizontal",
      },
    },
  },
  pickers = {
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

local builtin = require "telescope.builtin"
vim.keymap.set("n", "<C-p>", builtin.find_files, {
  desc = "Open telescope file search.",
  silent = true,
})

vim.keymap.set("n", "<C-_>", builtin.live_grep, {
  desc = "Open telescope live grep search.",
  silent = true,
})

vim.keymap.set("n", "<space>t", builtin.diagnostics, {
  desc = "Fuzzy search diagnostics.",
  silent = true,
})

-- LSP keymaps are in lua/plugins/config/lsp/common.lua
