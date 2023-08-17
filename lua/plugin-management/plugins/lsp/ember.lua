local common = require "lsp.common"
local lspconfig = require "lspconfig"

lspconfig.ember.setup {
  capabilities = common.capabilities,
  filetypes = {
    "html.handlebars",
    "handlebars",
  },
  handlers = common.handlers,
}
