" Java file type settings

" enable syntax folding
setlocal foldmethod=syntax

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
setlocal textwidth=100

" Add base java tags to tags watch list.
setlocal tags+=~/.vim/tags/java

" Set the ALE linters to run for java
let b:ale_linters = {
    \ 'java' : ['checkstyle', 'pmd']
    \ }

" Map organize imports to F4
nnoremap <silent> <F4> :CocCommand java.action.organizeImports<cr>
