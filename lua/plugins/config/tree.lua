vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local api = require "nvim-tree.api"
local ehandler = require("error-handler").handler

require("nvim-tree").setup {
  on_attach = function(bufnr)
    api.config.mappings.default_on_attach(bufnr)

    xpcall(vim.keymap.del, ehandler, "n", "<C-e>", { buffer = bufnr })
    xpcall(vim.keymap.del, ehandler, "n", "<C-x>", { buffer = bufnr })

    vim.keymap.set("n", "<C-s>", api.node.open.horizontal, {
      desc = "Open: Horizontal Split",
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    })
  end,
  disable_netrw = true,
  reload_on_bufenter = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  view = { adaptive_size = true },
  renderer = {
    add_trailing = true,
    group_empty = true,
    full_name = true,
    highlight_git = true,
    icons = {
      git_placement = "after",
    },
  },
  actions = {
    change_dir = {
      enable = false,
    },
    open_file = {
      quit_on_open = true,
    },
  },
}

vim.keymap.set("n", "<C-n>", function()
  require("nvim-tree.api").tree.toggle()
end, {
  desc = "Toggle the nvim-tree window.",
  silent = true,
})
