-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPre",
  opts = {
    enable = true,
  },
}
