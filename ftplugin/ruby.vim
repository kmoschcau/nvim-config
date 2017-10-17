" Ruby filetype settings

" Add tags generated for gems to the tags watch list
set tags+=gems.tags

" Customize some highlight groups for noprompt/vim-yardoc.
highlight link yardGenericTag rubyAttribute
highlight link yardDuckType rubyFunction
highlight link yardType rubyConstant
highlight link yardLiteral rubyPseudoVariable

" Fix the wrongly linked groups in noprompt/vim-yardoc.
highlight link yardYield yardGenericTag
highlight link yardYieldParam yardGenericTag
highlight link yardYieldReturn yardGenericTag
