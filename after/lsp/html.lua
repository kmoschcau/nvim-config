---@type vim.lsp.Config
return {
  filetypes = {
    "jsp",
    -- default ones below
    "html",
    "templ",
  },
  settings = {
    html = require("lsp.common").settings.html,
  },
}
