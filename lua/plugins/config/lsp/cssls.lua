local common = require "plugins.config.lsp.common"
local lspconfig = require "lspconfig"

lspconfig.cssls.setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    -- https://code.visualstudio.com/docs/languages/css
    css = {
      format = {
        enable = false,
      },
    },
    less = {
      format = {
        enable = false,
      },
    },
    scss = {
      format = {
        enable = false,
      },
    },
  },
}
