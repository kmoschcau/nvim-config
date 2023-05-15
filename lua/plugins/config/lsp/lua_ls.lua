local common = require "plugins.config.lsp.common"
local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Both",
      },
      format = {
        enable = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
