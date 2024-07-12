local common = require "lsp.common"

require("lspconfig").cssls.setup {
  cmd = {
    require("system-compat").append_win_ext "vscode-css-language-server",
    "--stdio",
  },
  settings = {
    css = common.settings.css,
    less = common.settings.less,
    scss = common.settings.scss,
  },
}
