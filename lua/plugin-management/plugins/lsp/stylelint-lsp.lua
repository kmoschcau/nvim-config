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
    "", -- FIXME: Remove once https://github.com/neovim/nvim-lspconfig/pull/3324 is merged
    "",
    "",
    "",
  },
  -- https://github.com/bmatcuk/stylelint-lsp?tab=readme-ov-file#settings
  settings = {},
}
