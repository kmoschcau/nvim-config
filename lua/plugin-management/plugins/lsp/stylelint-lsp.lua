local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.stylelint_lsp.setup {
  cmd = { compat.append_win_ext "stylelint-lsp", "--stdio" },
  capabilities = common.capabilities,
  filetypes = {
    "css",
    "less",
    "scss",
    "sugarss",
    "vue",
    "wxss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",

    "svelte",
  },
  handlers = common.handlers,
}
