---@type vim.lsp.Config
return {
  filetypes = {
    -- cspell:disable
    "html", -- needs stylelint-config-html
    -- default ones below
    "css",
    "less",
    "scss",
    "sugarss",
    "vue",
    "wxss",
    -- cspell:enable
  },
  -- https://github.com/bmatcuk/stylelint-lsp?tab=readme-ov-file#settings
  settings = {},
}
