" vim: foldmethod=marker
" Java file type settings

" general Vim settings {{{1
" Vim options {{{2

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
setlocal textwidth=100

" key bindings {{{2

" coc.nvim | neoclide/coc.nvim {{{3

nnoremap <silent><buffer> <F4>  :CocCommand java.action.organizeImports<cr>

" Vimspector | puremourning/vimspector {{{3

nnoremap <silent><buffer> <F12> :CocCommand java.debug.vimspector.start<cr>

" Asynchronous Line Engine | w0rp/ale {{{1

" Set the ALE linters to run for java
let b:ale_linters = { 'java' : ['checkstyle', 'pmd'] }
