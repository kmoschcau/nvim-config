" Markdown filetype settings

" Set the foldlevel to not fold anything by default.
setlocal foldlevel=99

" Do not show trailing spaces in airline.
let b:airline_whitespace_checks = [ 'indent', 'long', 'mixed-indent-file' ]
