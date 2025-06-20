-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "andymass/vim-matchup",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  init = function()
    vim.g.matchup_matchparen_offscreen = {
      border = "none",
      method = "popup",
    }
  end,
}
