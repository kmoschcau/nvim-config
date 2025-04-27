--- @type vim.lsp.Config
return {
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
