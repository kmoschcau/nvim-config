-- cspell:words navic

require("nvim-navic").setup {
  icons = require("kmo.symbols").types,
  highlight = true,
  lsp = {
    auto_attach = true,
    preference = {
      "vue_ls",
      "typescript-tools",
      "ts_ls",
    },
  },
  separator = " " .. require("kmo.symbols").separators.hierarchy.right .. " ",
}
