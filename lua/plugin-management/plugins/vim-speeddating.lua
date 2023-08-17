return {
  "tpope/vim-speeddating",
  config = function()
    vim.cmd.SpeedDatingFormat "%d.%m.%Y" -- German date format
  end,
}
