local common = require "plugins.config.lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.yamlls.setup {
  cmd = { compat.append_win_ext "yaml-language-server" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
}
