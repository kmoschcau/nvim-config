local common = require "lsp.common"
local lspconfig = require "lspconfig"

lspconfig.emmet_language_server.setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
  init_options = {
    preferences = {
      output = {
        selfClosingStyle = "xhtml",
      },
    },
  },
}
