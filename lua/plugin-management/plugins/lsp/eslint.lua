require("lspconfig").eslint.setup {
  cmd = {
    require("system-compat").append_win_ext "vscode-eslint-language-server",
    "--stdio",
  },
  filetypes = {
    "html", -- needs @html-eslint/parser
    -- default ones below
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte",
    "astro",
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
