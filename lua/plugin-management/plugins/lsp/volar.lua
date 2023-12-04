local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.volar.setup {
  cmd = { compat.append_win_ext "vue-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
}
