" vim: foldmethod=marker
" JSON with comments filetype settings

" general Vim settings {{{1
" Vim options {{{2

" Enable folding by syntax.
if has('nvim') || has('folding')
  setlocal foldmethod=syntax
endif

" plugin configurations {{{1
" ale | dense-analysis/ale {{{2

" Set the ignored ALE linters to run for json
let b:ale_linters_ignore = { 'json' : ['eslint'],
                           \ 'jsonc' : ['eslint'] }
