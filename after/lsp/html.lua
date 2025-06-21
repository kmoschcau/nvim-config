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
  settings = {
    html = require("lsp.common").settings.html,
  },
}
