" vim: foldmethod=marker
" Fish filetype settings

" general Vim settings {{{1
" non option settings {{{2

" Set up :make to use fish for syntax checking.
compiler fish

" Vim options {{{2

" Enable folding of block structures in fish.
if has('nvim') || has('folding')
  setlocal foldmethod=expr
endif
