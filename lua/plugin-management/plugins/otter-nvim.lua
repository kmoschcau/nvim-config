-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- FIXME: This might not work with nvim-treesitter main branch
  "jmbuhr/otter.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = true,
}
