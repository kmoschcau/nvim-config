" vim: foldmethod=marker
" Markdown filetype settings

" general Vim settings {{{1
" Vim options {{{2

" Set the foldlevel to not fold anything by default.
setlocal foldlevel=99

" vim-airline | vim-airline/vim-airline {{{1

" Do not show trailing spaces in airline.
let b:airline_whitespace_checks = [ 'indent', 'long', 'mixed-indent-file' ]
