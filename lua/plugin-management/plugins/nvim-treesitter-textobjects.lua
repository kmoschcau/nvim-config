-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {
    -- cspell:disable
    "nvim-treesitter/nvim-treesitter",
    -- cspell:enable
  },
}
