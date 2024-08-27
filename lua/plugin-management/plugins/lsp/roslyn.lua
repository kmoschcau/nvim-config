local common = require "lsp.common"

-- This doesn't yet have the same capabilities as omnisharp. I'll just leave the
-- setup here for now.
require("roslyn").setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
  on_attach = require "lsp.attach",
}
