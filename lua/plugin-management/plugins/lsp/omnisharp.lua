local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.omnisharp.setup {
  cmd = { compat.append_win_ext "omnisharp" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  -- Configuration is done in `~/.omnisharp/`.
}
