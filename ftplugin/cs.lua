-- vim: foldmethod=marker
-- C# file type settings

-- general Neovim settings {{{1
-- Neovim options {{{2

vim.opt_local.endofline = false
vim.opt_local.fixendofline = false
if vim.opt_local.modifiable:get() then
  vim.opt_local.fileformat = "dos"
end
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.textwidth = 120
