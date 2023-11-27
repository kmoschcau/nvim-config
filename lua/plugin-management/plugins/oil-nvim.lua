return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup {}
    vim.keymap.set("n", "-", require("oil.actions").parent.callback, {
      desc = "Open parent directory of current buffer.",
      silent = true,
    })
  end
}
