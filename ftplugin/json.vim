" vim: foldmethod=marker
" JSON filetype settings

" general Vim settings {{{1
" Vim options {{{2

" Enable folding by syntax.
if has('nvim') || has('folding')
  setlocal foldmethod=syntax
endif
