-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = "williamboman/mason.nvim",
  --- @type MasonLspconfigSettings
  opts = {
    automatic_installation = true,
  },
}
