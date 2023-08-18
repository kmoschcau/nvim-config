return {
  "SmiteshP/nvim-navbuddy",
  cmd = "Navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    icons = require("icons").types,
  },
}
