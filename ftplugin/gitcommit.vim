" vim: foldmethod=marker
" Git commit message file type settings

" general Vim settings {{{1
" Vim options {{{2

" Add an additional color column for the summary line after 50 characters.
if has('nvim') || has('syntax')
  setlocal colorcolumn+=51
endif

" enable syntax folding
if has('nvim') || has('folding')
  setlocal foldmethod=syntax
endif
