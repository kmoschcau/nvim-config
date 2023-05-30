local common = require "plugins.config.lsp.common"
local lspconfig = require "lspconfig"

lspconfig.html.setup {
  capabilities = common.capabilities,
  filetypes = { "html", "jsp" },
  handlers = common.handlers,
  settings = {
    -- https://code.visualstudio.com/docs/languages/html
    html = {
      suggest = {
        html5 = true,
      },
      format = {
        enable = false,
      },
    },
  },
}
