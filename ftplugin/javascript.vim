" vim: foldmethod=marker
" Javascript file type settings

" general Vim settings {{{1
" Vim options {{{2

" enable syntax folding
if has('nvim') || has('folding')
  setlocal foldmethod=syntax
endif
