-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "Zeioth/garbage-day.nvim",
  dependencies = {
    -- cspell:disable
    "neovim/nvim-lspconfig",
    -- cspell:enable
  },
  opts = {
    notifications = true,
  },
}
