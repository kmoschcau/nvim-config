" vim: foldmethod=marker
" Java file type settings

" general Vim settings {{{1
" Vim options {{{2

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
setlocal textwidth=100

" key bindings {{{2
" plugin key maps {{{3
" coc.nvim | neoclide/coc.nvim {{{4

nnoremap <silent><buffer> <F4>  :CocCommand java.action.organizeImports<cr>

" vimspector | puremourning/vimspector {{{4

nnoremap <silent><buffer> <F12> :CocCommand java.debug.vimspector.start<cr>

" plugin configurations {{{1
" ale | dense-analysis/ale {{{2

" Set the ALE linters to run for java
let b:ale_linters = { 'java' : ['checkstyle', 'pmd'] }
