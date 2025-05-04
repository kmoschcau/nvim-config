local common = require "lsp.common"

---@type vim.lsp.Config
return {
  -- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
  settings = {
    css = common.settings.css,
    less = common.settings.less,
    scss = common.settings.scss,
    javascript = common.settings.javascript,
    typescript = common.settings.typescript,
  },
}
