" Vim: set foldmethod=marker:
" Java file type settings

" general Vim settings {{{1
" Vim options {{{2

" enable syntax folding
setlocal foldmethod=syntax

" Add base java tags to tags watch list.
setlocal tags+=~/.vim/tags/java

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
setlocal textwidth=100

" If this many milliseconds nothing is typed the swap file will be written to
" disk. Also used for the CursorHold autocommand event.
set updatetime=4000

" key bindings {{{2

nnoremap <silent> <F4> :CocCommand java.action.organizeImports<cr>

" Asynchronous Line Engine | w0rp/ale {{{1

" Set the ALE linters to run for java
let b:ale_linters = { 'java' : ['checkstyle', 'pmd'] }
