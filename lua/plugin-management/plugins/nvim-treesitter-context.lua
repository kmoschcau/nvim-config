-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPre",
}
