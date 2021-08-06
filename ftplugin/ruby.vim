" vim: foldmethod=marker
" Ruby filetype settings

" general Vim settings {{{1
" key bindings {{{2

if expand('%:t:r') =~? '_spec$'
  nnoremap <buffer> <LocalLeader>t :call RSpec_RunCurrentSpecFile()<cr>
  nnoremap <buffer> <LocalLeader>s :call RSpec_RunNearestSpec()<cr>
  nnoremap <buffer> <LocalLeader>l :call RSpec_RunLastSpec()<cr>
  nnoremap <buffer> <LocalLeader>a :call RSpec_RunAllSpecs()<cr>
endif

" plugin configurations {{{1
" ale | dense-analysis/ale {{{2

" This variable can be changed to modify flags given to rubocop.
let g:ale_ruby_rubocop_options = '--display-cop-names
                                \ --extra-details
                                \ --display-style-guide'
