-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- FIXME: This might not work with nvim-treesitter main branch
  -- cspell:disable-next-line
  "jmbuhr/otter.nvim",
  dependencies = {
    -- cspell:disable
    "nvim-treesitter/nvim-treesitter",
    -- cspell:enable
  },
  config = true,
}
