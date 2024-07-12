require("lspconfig").stylelint_lsp.setup {
  cmd = { require("system-compat").append_win_ext "stylelint-lsp", "--stdio" },
  filetypes = {
    "css",
    "less",
    "scss",
    "sugarss",
    "vue",
    "wxss",
    "javascriptreact",
    "typescriptreact",

    "svelte",
  },
  -- https://github.com/bmatcuk/stylelint-lsp?tab=readme-ov-file#settings
  settings = {},
}
