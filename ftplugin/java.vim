" vim: foldmethod=marker
" Java file type settings

" general Vim settings {{{1
" Vim options {{{2

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
setlocal textwidth=100

" key bindings {{{2
" plugin key maps {{{3

" vimspector | puremourning/vimspector {{{4

nnoremap <silent><buffer> <F12> :CocCommand java.debug.vimspector.start<cr>

" User commands {{{2

function! s:GoogleJavaFormat(start, end)
  execute '%!google-java-format -'
        \ '--skip-reflowing-long-strings'
        \ '--skip-sorting-imports'
        \ '--skip-removing-unused-imports'
        \ '--lines' a:start . ':' . a:end
        \ '2> /dev/null'
  execute a:start
endfunction
command -range=% GoogleJavaFormat :call s:GoogleJavaFormat(<line1>, <line2>)

" plugin configurations {{{1
" ale | dense-analysis/ale {{{2

" Set the ALE linters to run for java
let b:ale_linters = { 'java' : ['checkstyle', 'pmd'] }
