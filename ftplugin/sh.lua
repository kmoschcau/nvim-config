-- vim: foldmethod=marker
-- Shell file type settings

-- general Vim settings {{{1
-- Vim options {{{2

vim.opt_local.shiftwidth = 4

-- plugin configurations {{{1
-- ale | dense-analysis/ale {{{2

-- Set the ALE fixers to run for shell.
vim.b.ale_fixers = { sh = { "shfmt" } }
