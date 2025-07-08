local common = require "lsp.common"
local tsserver = require "lsp.common.tsserver"

---@type vim.lsp.Config
return {
  -- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
  settings = {
    css = common.settings.css,
    less = common.settings.less,
    scss = common.settings.scss,
    javascript = tsserver.settings.javascript,
    typescript = tsserver.settings.typescript,
  },
}
