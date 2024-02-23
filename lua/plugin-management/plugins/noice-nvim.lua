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
          pattern = "^:%s*G",
          icon = require("symbols").noice.cmdline.fugitive,
        },
      },
    },
    popupmenu = { backend = "cmp" },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    --- @type NoiceRouteConfig[]
    routes = {
      {
        view = "mini",
        filter = {
          any = {
            -- see |ui-messages|
            {
              event = "msg_show",
            },
            {
              event = "msg_showmode",
            },
            {
              event = "msg_showcmd",
            },
            {
              event = "msg_ruler",
            },
          },
        },
      },
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
  },
}
