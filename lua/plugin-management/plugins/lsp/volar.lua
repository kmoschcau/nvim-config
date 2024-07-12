local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)

require("lspconfig").volar.setup {
  autostart = config.use_volar,
  cmd = {
    require("system-compat").append_win_ext "vue-language-server",
    "--stdio",
  },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
}
