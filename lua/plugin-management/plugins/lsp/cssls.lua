local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.cssls.setup {
  cmd = { compat.append_win_ext "vscode-css-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    -- https://code.visualstudio.com/docs/languages/css
    css = {
      format = {
        enable = false,
      },
    },
    less = {
      format = {
        enable = false,
      },
    },
    scss = {
      format = {
        enable = false,
      },
    },
  },
}
