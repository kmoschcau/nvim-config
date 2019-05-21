" Vim: set foldmethod=marker:
" CSS filetype settings

" general Vim settings {{{1
" Vim options {{{2

" Enables plugins to highlight keywords with dashes
setlocal iskeyword+=-

" coc.nvim | neoclide/coc.nvim {{{1

" Enable coc.nvim to properly complete for keywords with dashes
let b:coc_additional_keywords = ['-']
