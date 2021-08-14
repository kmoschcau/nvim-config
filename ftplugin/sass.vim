" vim: foldmethod=marker
" SASS filetype settings

" general Vim settings {{{1
" Vim options {{{2

" Enables plugins to highlight keywords with dashes
setlocal iskeyword+=-

" plugin configurations {{{1
" coc.nvim | neoclide/coc.nvim {{{2

" Enable coc.nvim to properly complete for keywords with dashes
let b:coc_additional_keywords = ['-']
