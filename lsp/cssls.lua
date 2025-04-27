local common = require "lsp.common"

---@type vim.lsp.Config
return {
  settings = {
    css = common.settings.css,
    less = common.settings.less,
    scss = common.settings.scss,
  },
}
