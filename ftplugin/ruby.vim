"" ruby dependent settings

" formatting options
set formatoptions +=j

" add tags generated for gems to the tags watch list
set tags +=gems.tags

" enable ruby operator highlighting
" currently has a bug when highlighting heredocs
" let ruby_operators = 1

" some modifications for noprompt/vim-yardoc
highlight link yardGenericTag rubyAttribute
highlight link yardDuckType rubyFunction
highlight link yardType rubyConstant
highlight link yardLiteral rubyPseudoVariable

" fix for wrongly linked groups in plugin
highlight link yardYield yardGenericTag
highlight link yardYieldParam yardGenericTag
highlight link yardYieldReturn yardGenericTag
