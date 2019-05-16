" Ruby filetype settings

" Add tags generated for gems to the tags watch list
setlocal tags+=gems.tags

" Set the foldlevel to not fold anything by default.
setlocal foldlevel=99

" Customize some highlight groups for noprompt/vim-yardoc.
highlight link yardGenericTag rubyAttribute
highlight link yardDuckType rubyFunction
highlight link yardType rubyConstant
highlight link yardLiteral rubyPseudoVariable

" Fix the wrongly linked groups in noprompt/vim-yardoc.
highlight link yardYield yardGenericTag
highlight link yardYieldParam yardGenericTag
highlight link yardYieldReturn yardGenericTag

" key bindings {{{1

nnoremap <buffer> <LocalLeader>r  :RunSpec<cr>
nnoremap <buffer> <LocalLeader>l  :RunSpecLine<cr>
nnoremap <buffer> <LocalLeader>e  :RunSpecLastRun<cr>
nnoremap <buffer> <LocalLeader>cr :RunSpecCloseResult<cr>
