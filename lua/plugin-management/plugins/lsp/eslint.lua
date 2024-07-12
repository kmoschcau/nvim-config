require("lspconfig").eslint.setup {
  cmd = {
    require("system-compat").append_win_ext "vscode-eslint-language-server",
    "--stdio",
  },
  -- https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint#settings-options
  settings = {
    eslint = {
      experimental = {
        useFlatConfig = true,
      },
      format = {
        enable = false,
      },
      probe = {
        "html",
        "javascript",
        "javascriptreact",
        "markdown",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
      },
    },
  },
}
