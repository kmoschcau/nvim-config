--- @type LazyPluginSpec
return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  name = "markdown.nvim-render",
  ft = "markdown",
  --- @type render.md.UserConfig
  opts = {
    dash = {
      highlight = "NonText",
    },
  },
}
