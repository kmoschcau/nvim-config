-- vim: foldmethod=marker
-- Tim Pope's fugitive plug-in file type settings

-- general Neovim settings {{{1
-- Neovim options {{{2

-- Set the color column to be two more than textwidth, since in diffs we usually
-- have one column more at the beginning of a line.
vim.opt_local.colorcolumn = "+2"

vim.keymap.set("n", "CC", "<Cmd>G commit --no-verify<CR>", {
  buffer = true,
  silent = true,
  desc = "Commit without git hooks."
})
