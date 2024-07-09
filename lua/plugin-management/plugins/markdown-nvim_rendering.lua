--- @type LazyPluginSpec
return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "echasnovski/mini.icons" },
  name = "markdown.nvim-render",
  ft = "markdown",
  opts = {
    dash = {
      highlight = "NonText",
    },
  },
}
