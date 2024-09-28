require("lspconfig").ember.setup {
  filetypes = {
    "handlebars",
    "", -- FIXME: Remove once https://github.com/neovim/nvim-lspconfig/issues/3323 is fixed
    "",
    "typescript.glimmer",
    "javascript.glimmer",
  },
  -- https://marketplace.visualstudio.com/items?itemName=lifeart.vscode-ember-unstable
  settings = {},
}
