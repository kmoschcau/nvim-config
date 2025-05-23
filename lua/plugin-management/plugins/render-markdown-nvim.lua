-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  ft = "markdown",
  ---@type render.md.UserConfig
  opts = {
    code = {
      left_pad = 1,
      right_pad = 1,
      width = "block",
    },
    completions = {
      lsp = {
        enabled = true,
      },
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
    win_options = {
      conceallevel = {
        rendered = 2,
      },
    },
  },
}
