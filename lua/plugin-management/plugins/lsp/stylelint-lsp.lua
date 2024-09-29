require("lspconfig").stylelint_lsp.setup {
  cmd = { require("system-compat").append_win_ext "stylelint-lsp", "--stdio" },
  filetypes = {
    "html", -- needs stylelint-config-html
    -- default ones below
    "css",
    "less",
    "scss",
    "sugarss",
    "vue",
    "wxss",
  },
  -- https://github.com/bmatcuk/stylelint-lsp?tab=readme-ov-file#settings
  settings = {},
}
