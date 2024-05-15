--- @type LazyPluginSpec
return {
  "MeanderingProgrammer/markdown.nvim",
  name = "markdown.nvim-render",
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = "markdown",
  opts = {
    highlights = {
      dash = "NonText",
    },
  },
}
