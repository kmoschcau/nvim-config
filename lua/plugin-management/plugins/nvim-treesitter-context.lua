-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPre",
  opts = {
    enable = true,
  },
}
