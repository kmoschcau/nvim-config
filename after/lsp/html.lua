---@type vim.lsp.Config
return {
  filetypes = {
    -- cspell:disable
    "jsp",
    -- default ones below
    "html",
    "templ",
    -- cspell:enable
  },
  settings = require("lsp.common.vscode-html").settings,
}
