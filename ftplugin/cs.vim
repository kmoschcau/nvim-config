" vim: foldmethod=marker
" C# file type settings

" general Vim settings {{{1
" Vim options {{{2

" enable syntax folding
if has('nvim') || has('folding')
  setlocal foldmethod=syntax
endif

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
setlocal textwidth=120
