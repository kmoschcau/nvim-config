--- @type LazyPluginSpec
return {
  "SmiteshP/nvim-navic",
  dependencies = "neovim/nvim-lspconfig",
  -- @type Options -- Does not work, conflicts with other type definitions
  opts = {
    highlight = true,
    icons = require("symbols").types,
  },
}
