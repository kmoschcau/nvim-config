local common = require "lsp.common"

require("lspconfig").svelte.setup {
  cmd = { require("system-compat").append_win_ext "svelteserver", "--stdio" },
  -- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
  settings = {
    css = common.settings.css,
    less = common.settings.less,
    scss = common.settings.scss,
    javascript = common.settings.javascript,
    typescript = common.settings.typescript,
  },
}
