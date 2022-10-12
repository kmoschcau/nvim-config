-- vim: foldmethod=marker
-- Rust file type settings

-- general Vim settings {{{1
-- Vim options {{{2

vim.opt_local.foldmethod = "syntax"

-- plugin configurations {{{1
-- ale | dense-analysis/ale {{{2

-- Use cargo clippy, when it is installed.
vim.g.ale_rust_cargo_use_clippy = vim.fn.executable("cargo-clippy") > 0

-- Set the rls toolchain to stable.
vim.g.ale_rust_rls_toolchain = "stable"

-- Set the ALE linters to run for rust.
vim.b.ale_linters = { rust = { "cargo", "rls" } }

-- Set the ALE fixers to run for rust.
vim.b.ale_fixers = { rust = { "rustfmt" } }
