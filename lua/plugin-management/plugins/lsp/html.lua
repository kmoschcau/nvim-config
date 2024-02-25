local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.html.setup {
  cmd = { compat.append_win_ext "vscode-html-language-server", "--stdio" },
  capabilities = common.capabilities,
  filetypes = { "html", "jsp", "templ" },
  handlers = common.handlers,
  settings = {
    html = common.settings.html
  },
}
