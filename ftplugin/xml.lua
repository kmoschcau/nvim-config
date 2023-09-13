-- vim: foldmethod=marker
-- XML file type settings

-- general Neovim settings {{{1
-- Neovim options {{{2

if vim.fn.expand("%:e") == "xaml" then
  require("system-compat").set_dos_file_options()
end
