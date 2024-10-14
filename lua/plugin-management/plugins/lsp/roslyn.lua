local common = require "lsp.common"

-- NOTE: Currently this doesn't start.
-- See: https://github.com/seblj/roslyn.nvim/issues/63
--
-- NOTE: Last time I checked, this didn't yet have the same capabilities as
-- omnisharp. I'll just leave the setup here for now.
require("roslyn").setup {
  config = {
    capabilities = common.capabilities,
    handlers = common.handlers,
    on_attach = require "lsp.attach",
  },
}
