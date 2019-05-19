" Enables plugins to highlight keywords with dashes
setlocal iskeyword+=-

" Enable coc.nvim to properly complete for keywords with dashes
let b:coc_additional_keywords = ['-']
