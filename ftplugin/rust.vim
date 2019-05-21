" Vim: set foldmethod=marker:
" Rust filetype settings

" Asynchronous Lint Engine | w0rp/ale {{{1

" Use cargo clippy, when it is installed.
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

" Set the rls toolchain to stable.
let g:ale_rust_rls_toolchain = 'stable'

" Set the ALE linters to run for rust.
let b:ale_linters = { 'rust' : ['cargo', 'rls'] }

" Set the ALE fixers to run for rust.
let b:ale_fixers = { 'rust' : ['rustfmt'] }
