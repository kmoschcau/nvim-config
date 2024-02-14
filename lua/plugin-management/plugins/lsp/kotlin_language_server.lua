local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.kotlin_language_server.setup {
  cmd = { compat.append_win_ext "kotlin-language-server" },
  capabilities = common.capabilities,
  handlers = common.handlers,

  settings = {
    -- https://github.com/fwcd/vscode-kotlin/blob/main/package.json
    kotlin = {
      inlayHints = {
        chainedHints = true,
        parameterHints = true,
        typeHints = true,
      },
    },
  },
}
