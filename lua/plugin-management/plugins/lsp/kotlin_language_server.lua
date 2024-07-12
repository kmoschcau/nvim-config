require("lspconfig").kotlin_language_server.setup {
  cmd = { require("system-compat").append_win_ext "kotlin-language-server" },
  -- https://github.com/fwcd/vscode-kotlin/blob/main/package.json
  settings = {
    kotlin = {
      inlayHints = {
        chainedHints = true,
        parameterHints = true,
        typeHints = true,
      },
    },
  },
}
