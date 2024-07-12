--- @type LazyPluginSpec
return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "echasnovski/mini.icons" },
  name = "markdown.nvim-render",
  ft = "markdown",
  -- @type render.md.Config -- Does not work well, no optional fields
  opts = {
    dash = {
      highlight = "NonText",
    },
    exclude = {
      buftypes = {
        "nofile",
      },
    },
  },
}
