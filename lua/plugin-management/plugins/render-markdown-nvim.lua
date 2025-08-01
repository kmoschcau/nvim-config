-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    -- cspell:disable
    "echasnovski/mini.nvim",
    -- cspell:enable
  },
  ft = "markdown",
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  opts = {
    code = {
      language_border = "▄",
      language_left = "🭃",
      language_right = "🭎",
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
