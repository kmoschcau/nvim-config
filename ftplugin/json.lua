-- vim: foldmethod=marker
-- JSON file type settings

-- general Vim settings {{{1
-- Vim options {{{2

vim.opt_local.foldmethod = "syntax"

-- plugin configurations {{{1
-- ale | dense-analysis/ale {{{2

-- Set the ignored ALE linters to run for json
vim.b.ale_linters_ignore = { json = { "eslint" }, jsonc = { "eslint" } }
