" vim: foldmethod=marker
" Ruby filetype settings

" general Vim settings {{{1
" Vim options {{{2

" Add tags generated for gems to the tags watch list
setlocal tags+=gems.tags

" key bindings {{{2

if expand('%:t:r') =~? '_spec$'
  nnoremap <buffer> <LocalLeader>t :call RSpec_RunCurrentSpecFile()<cr>
  nnoremap <buffer> <LocalLeader>s :call RSpec_RunNearestSpec()<cr>
  nnoremap <buffer> <LocalLeader>l :call RSpec_RunLastSpec()<cr>
  nnoremap <buffer> <LocalLeader>a :call RSpec_RunAllSpecs()<cr>
endif

" Asynchronous Lint Engine | w0rp/ale {{{1

" This variable can be changed to modify flags given to rubocop.
let g:ale_ruby_rubocop_options = '--display-cop-names
                                \ --extra-details
                                \ --display-style-guide'
