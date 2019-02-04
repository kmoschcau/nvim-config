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

if expand('%:t:r') =~ '_spec$'
  nnoremap <buffer> <LocalLeader>t :call RSpec_RunCurrentSpecFile()<cr>
  nnoremap <buffer> <LocalLeader>s :call RSpec_RunNearestSpec()<cr>
  nnoremap <buffer> <LocalLeader>l :call RSpec_RunLastSpec()<cr>
  nnoremap <buffer> <LocalLeader>a :call RSpec_RunAllSpecs()<cr>
endif
