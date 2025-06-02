-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "andymass/vim-matchup",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  init = function()
    -- NOTE: This is currently broken.
    -- See: https://github.com/andymass/vim-matchup/issues/391
    -- vim.g.matchup_matchparen_offscreen = {
    --   border = "none",
    --   method = "popup",
    -- }
  end,
}
