require("lspconfig").volar.setup {
  cmd = {
    require("system-compat").append_win_ext "vue-language-server",
    "--stdio",
  },
}
