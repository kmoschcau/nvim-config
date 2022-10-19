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
}

require("telescope").load_extension "fzf"

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

-- LSP keymaps are in lua/plugins/config/lsp.lua
