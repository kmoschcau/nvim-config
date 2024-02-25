local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.eslint.setup {
  cmd = { compat.append_win_ext "vscode-eslint-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  -- https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint#settings-options
  settings = {
    eslint = {
      experimental = {
        useFlatConfig = true,
      },
      format = {
        enable = false,
      },
      probe = {
        "html",
        "javascript",
        "javascriptreact",
        "markdown",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
      },
    },
  },
}
