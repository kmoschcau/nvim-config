local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.yamlls.setup {
  cmd = { compat.append_win_ext "yaml-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
}
