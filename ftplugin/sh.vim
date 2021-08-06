" vim: foldmethod=marker
" Shell filetype settings

" plugin configurations {{{1
" ale | dense-analysis/ale {{{2

" Set the ALE fixers to run for shell.
let b:ale_fixers = { 'sh' : ['shfmt'] }
