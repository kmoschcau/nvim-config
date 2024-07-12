require("lspconfig").jsonls.setup {
  cmd = {
    require("system-compat").append_win_ext "vscode-json-language-server",
    "--stdio",
  },
  -- https://code.visualstudio.com/docs/languages/json
  settings = {
    json = {
      format = {
        enable = false,
      },
    },
  },
}
