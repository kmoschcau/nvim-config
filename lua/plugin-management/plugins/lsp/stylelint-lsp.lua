local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.stylelint_lsp.setup {
  cmd = { compat.append_win_ext "stylelint-lsp", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  filetypes = {
    "css",
    "javascriptreact",
    "less",
    "scss",
    "sugarss",
    "svelte",
    "typescriptreact",
    "vue",
    "wxss",
  },
  settings = {},
}
