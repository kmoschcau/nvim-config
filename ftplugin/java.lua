-- vim: foldmethod=marker
-- Java file type settings

-- general Neovim settings {{{1
-- Neovim options {{{2

vim.opt_local.textwidth = 100

-- plugin configurations {{{1
-- jdtls | mfussenegger/nvim-jdtls {{{2

require("plugins.config.lsp.jdtls").start_or_attach()
