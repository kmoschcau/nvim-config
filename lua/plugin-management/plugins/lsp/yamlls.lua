local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.yamlls.setup {
  cmd = { compat.append_win_ext "yaml-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  -- https://github.com/redhat-developer/yaml-language-server?tab=readme-ov-file#language-server-settings
  settings = {
    yaml = {
      schemastore = {
        enable = true,
      },
    },
  },
}
