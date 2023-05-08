local ehandler = require("error-handler").handler

-- vim: foldmethod=marker
-- Markdown file type settings

-- general Neovim settings {{{1
-- Neovim options {{{2

vim.opt_local.formatoptions:append "t"

-- plugin configurations {{{1

-- nvim-markdown | ixru/nvim-markdown {{{2

-- Remove the default `insert link` mapping, so that we can use digraphs.
xpcall(vim.keymap.del, ehandler, "i", "<C-k>", { buffer = true })
