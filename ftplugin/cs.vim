" vim: foldmethod=marker
" C# file type settings

" general Vim settings {{{1
" Vim options {{{2

" enable syntax folding
if has('nvim') || has('folding')
  setlocal foldmethod=syntax
endif

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
setlocal textwidth=120

" key bindings {{{2
" plugin key maps {{{3
" omnisharp-vim | Omnisharp/omnisharp-vim {{{4

nnoremap <silent><buffer> K      :OmniSharpDocumentation<cr>
nnoremap <silent><buffer> <C-s>s :OmniSharpSignatureHelp<cr>
nnoremap <silent><buffer> <C-s>d :OmniSharpGotoDefinition<cr>
nnoremap <silent><buffer> <C-s>i :OmniSharpFindImplementations<cr>
nnoremap <silent><buffer> <C-s>r :OmniSharpFindUsages<cr>
nnoremap <silent><buffer> <C-s>n :OmniSharpRename<cr>

nnoremap <silent><buffer> <F4>   :OmniSharpFixUsings<cr>

nnoremap <silent><buffer> [m     :OmniSharpNavigateUp<cr>
nnoremap <silent><buffer> ]m     :OmniSharpNavigateDown<cr>

" plugin configurations {{{1
" ale | dense-analysis/ale {{{2

" Set the ALE linters to run for C#
let b:ale_linters = { 'cs' : ['OmniSharp'] }
