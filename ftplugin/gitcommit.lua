-- vim: foldmethod=marker
-- Git commit message file type settings

-- general Neovim settings {{{1
-- Neovim options {{{2

local cc = vim.opt_local.colorcolumn --[[@as vim.opt.colorcolumn]]
cc:append "51"

vim.opt_local.foldmethod = "syntax"
vim.opt_local.formatoptions:remove "a"
vim.opt_local.textwidth = 72
