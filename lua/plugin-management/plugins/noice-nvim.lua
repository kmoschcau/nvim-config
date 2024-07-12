--- @type LazyPluginSpec
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  --- @type NoiceConfig
  opts = {
    cmdline = {
      --- @type table<string, CmdlineFormat>
      format = {
        fish = {
          pattern = "^:%s*ter?m?i?n?a?l?%s",
          icon = require("symbols").noice.cmdline.fish,
          lang = "fish",
        },
        fugitive = {
          pattern = "^:%s*Gi?t?%s",
          icon = require("symbols").noice.cmdline.fugitive,
        },
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    messages = {
      -- Messages can't update existing messages. This is a limitation of core.
      -- https://github.com/folke/noice.nvim/issues/544
      enabled = false,
    },
    popupmenu = {
      -- I don't use the popup-menu.
      enabled = false,
    },
    --- @type NoiceRouteConfig[]
    routes = {
      {
        view = "notify",
        filter = {
          any = {
            {
              find = "No information available",
            },
            {
              find = "method textDocument/codeLens is not supported by any of the servers registered for the current buffer",
            },
          },
        },
        opts = {
          level = vim.log.levels.DEBUG,
        },
      },
    },
    --- @type NoiceConfigViews
    views = {
      mini = {
        position = {
          row = -2,
        },
      },
    },
  },
}
