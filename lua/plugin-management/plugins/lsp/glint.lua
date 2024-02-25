local common = require "lsp.common"
local lspconfig = require "lspconfig"

lspconfig.glint.setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
}
