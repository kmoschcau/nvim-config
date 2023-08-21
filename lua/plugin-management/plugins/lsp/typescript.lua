local common = require "lsp.common"

require("typescript").setup {
  server = {
    capabilities = common.capabilities,
    handlers = common.handlers,
    settings = {
      javascript = common.settings.javascript,
      typescript = common.settings.typescript,
    },
  },
}
