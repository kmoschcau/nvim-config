-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "andymass/vim-matchup",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  init = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}
