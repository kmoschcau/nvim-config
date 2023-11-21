local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.tailwindcss.setup {
  cmd = { compat.append_win_ext "tailwindcss-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
    },
  },
}
