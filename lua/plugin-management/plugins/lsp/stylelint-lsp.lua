require("lspconfig").stylelint_lsp.setup {
  cmd = { require("system-compat").append_win_ext "stylelint-lsp", "--stdio" },
  filetypes = { -- FIXME: Remove once https://github.com/neovim/nvim-lspconfig/pull/3324 is merged
    "css",
    "less",
    "scss",
    "sugarss",
    "vue",
    "wxss",
    "",
    "",
    "",
    "",
  },
  -- https://github.com/bmatcuk/stylelint-lsp?tab=readme-ov-file#settings
  settings = {},
}
