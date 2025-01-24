require("lspconfig").html.setup {
  cmd = {
    require("system-compat").append_win_ext "vscode-html-language-server",
    "--stdio",
  },
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
