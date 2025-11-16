-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "SmiteshP/nvim-navic",
  dependencies = {
    -- cspell:disable
    "neovim/nvim-lspconfig",
    -- cspell:enable
  },
  -- @type Options -- Does not work, conflicts with other type definitions
  opts = {
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
  },
}
