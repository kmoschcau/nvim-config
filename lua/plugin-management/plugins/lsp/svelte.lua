local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.svelte.setup {
  cmd = { compat.append_win_ext "svelteserver", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  -- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
  settings = {
    css = common.settings.css,
    less = common.settings.less,
    scss = common.settings.scss,
    javascript = common.settings.javascript,
    typescript = common.settings.typescript,
  },
}
