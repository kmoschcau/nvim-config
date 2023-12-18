return {
  "Wansmer/treesj",
  keys = { "<space>m", "<space>j", "<space>sp" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local treesj = require "treesj"

    treesj.setup {
      use_default_keymaps = false,
    }

    vim.keymap.set("n", "<space>m", treesj.toggle, {
      desc = "Toggle treesj joining.",
    })

    vim.keymap.set("n", "<space>j", treesj.join, {
      desc = "treesj join.",
    })

    vim.keymap.set("n", "<space>sp", treesj.split, {
      desc = "treesj split.",
    })
  end,
}
