local common = require "plugins.config.lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.html.setup {
  cmd = { compat.append_win_ext "vscode-html-language-server", "--stdio" },
  capabilities = common.capabilities,
  filetypes = { "html", "jsp" },
  handlers = common.handlers,
  settings = {
    -- https://code.visualstudio.com/docs/languages/html
    html = {
      suggest = {
        html5 = true,
      },
      format = {
        enable = false,
      },
    },
  },
}
