--- @type LazyPluginSpec
return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  name = "markdown.nvim-render",
  ft = "markdown",
  --- @type render.md.UserConfig
  opts = {
    code = {
      left_pad = 1,
      right_pad = 1,
      width = "block",
    },
    dash = {
      highlight = "NonText",
    },
    overrides = {
      buftype = {
        nofile = {
          code = {
            left_pad = 0,
            right_pad = 0,
            width = "full",
          },
        },
      },
    },
  },
}
