local common = require "plugins.config.lsp.common"
local lspconfig = require "lspconfig"

lspconfig.yamlls.setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
}
