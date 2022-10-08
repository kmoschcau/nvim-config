vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require "nvim-tree".setup {
  disable_netrw = true,
  reload_on_bufenter = true,
  remove_keymaps = { "<C-e>" },
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
  view = {
    adaptive_size = true
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    full_name = true,
    highlight_git = true,
    icons = {
      git_placement = "after"
    }
  },
  actions = {
    change_dir = {
      enable = false
    },
    open_file = {
      quit_on_open = true
    }
  }
}

local api = require "nvim-tree.api"

vim.keymap.set("n", "<C-n>", function()
  api.tree.toggle()
end)
