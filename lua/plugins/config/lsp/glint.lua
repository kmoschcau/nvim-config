local common = require "plugins.config.lsp.common"
local lspconfig = require "lspconfig"

lspconfig.glint.setup {
  capabilities = common.capabilities,
  filetypes = {
    "html.handlebars",
    "handlebars",
    "typescript.glimmer",
    "javascript.glimmer",
  },
  handlers = common.handlers,
}
