local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.jsonls.setup {
  cmd = { compat.append_win_ext "vscode-json-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    -- https://code.visualstudio.com/docs/languages/json
    json = {
      format = {
        enable = false,
      },
    },
  },
}
