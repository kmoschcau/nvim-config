" Vim: set foldmethod=marker:
" Shell filetype settings

" Asynchronous Lint Engine | w0rp/ale {{{1

" Set the ALE fixers to run for shell.
let b:ale_fixers = { 'sh' : ['shfmt'] }
