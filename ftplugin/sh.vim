" vim: foldmethod=marker
" Shell filetype settings

" general Vim settings {{{1
" Vim options {{{2

" Number of spaces to use for each step of (auto)indent. When zero the 'tabstop'
" value will be used. Setting this independently from 'tabstop' allows for tabs
" to be a certain width in characters, but still only indent 'shiftwidth' with
" spaces.
set shiftwidth=4

" plugin configurations {{{1
" ale | dense-analysis/ale {{{2

" Set the ALE fixers to run for shell.
let b:ale_fixers = { 'sh' : ['shfmt'] }
