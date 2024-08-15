require("lspconfig").html.setup {
  cmd = {
    require("system-compat").append_win_ext "vscode-html-language-server",
    "--stdio",
  },
  filetypes = { "html", "jsp", "razor", "templ" },
  settings = {
    html = require("lsp.common").settings.html,
  },
}
