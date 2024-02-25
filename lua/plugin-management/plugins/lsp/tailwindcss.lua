local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.tailwindcss.setup {
  cmd = { compat.append_win_ext "tailwindcss-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  -- https://github.com/tailwindlabs/tailwindcss-intellisense?tab=readme-ov-file#extension-settings
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
    },
  },
}
