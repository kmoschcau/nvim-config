" Vim: set foldmethod=marker:
" Colorscheme file for custom vim-material
" A material theme for light and dark background. The custom highlight groups
" work best on a light background.

" first, load the original colorscheme
runtime colors/vim-material

" set the name of the colortheme
let g:colors_name = expand('<sfile>:t:r')

" custom variables {{{1
" terminal color variables {{{2
let g:terminal_color_0  = '#34383a'
let g:terminal_color_1  = '#e53935'
let g:terminal_color_2  = '#82a550'
let g:terminal_color_3  = '#ffad13'
let g:terminal_color_4  = '#6182b8'
let g:terminal_color_5  = '#945eb8'
let g:terminal_color_6  = '#39adb5'
let g:terminal_color_7  = '#aababc'
let g:terminal_color_8  = '#869093'
let g:terminal_color_9  = '#ff5370'
let g:terminal_color_10 = '#adce7d'
let g:terminal_color_11 = '#ffc14b'
let g:terminal_color_12 = '#82aaff'
let g:terminal_color_13 = '#bb80b3'
let g:terminal_color_14 = '#89ddff'
let g:terminal_color_15 = '#cddcde'

" custom highlight groups {{{1
" highlight groups for the terminal cursor {{{2

" Overridden highlight group for the cursor
highlight clear Cursor
highlight Cursor cterm=reverse guifg=#666666 guibg=#00BCD4

" Highlight groups for neovim's terminal cursor
highlight! link TermCursor Cursor
highlight clear TermCursorNC
highlight TermCursorNC cterm=reverse guifg=#666666 guibg=#0097A7

" highlight groups for search {{{2

" highlight group for incremental search
highlight clear IncSearch
highlight IncSearch ctermbg=208 guibg=#FFA000

" highlight group for last search pattern
highlight clear Search
highlight Search ctermbg=220 guibg=#FFC107

" highlight groups with changed/added cterm values {{{2

highlight NonText ctermbg=white ctermfg=black
highlight Normal  ctermbg=white ctermfg=black

" highlight groups for diffs {{{2

highlight clear DiffAdd
highlight clear DiffChange
highlight clear DiffText
highlight clear DiffDelete
highlight DiffAdd    ctermbg=193 guibg=#f0f4c3
highlight DiffChange ctermbg=229 guibg=#fff9c4
highlight DiffText   ctermbg=222 guibg=#ffe082 gui=bold
highlight DiffDelete ctermbg=216 guibg=#ffccbc

" highlight group for TODO {{{2

highlight clear Todo
highlight Todo cterm=bold gui=bold

" highlight groups for spelling {{{2

highlight clear SpellBad
highlight clear SpellCap
highlight clear SpellLocal
highlight clear SpellRare
highlight SpellBad   ctermbg=203 gui=undercurl guisp=#f44336
highlight SpellCap   ctermbg=33  gui=undercurl guisp=#2196f3
highlight SpellLocal ctermbg=30  gui=undercurl guisp=#00838f
highlight SpellRare  ctermbg=204 gui=undercurl guisp=#ff4081

" highlight groups for columns {{{2

highlight clear ColorColumn
highlight clear FoldColumn
highlight clear SignColumn
highlight link ColorColumn Folded
highlight link FoldColumn LineNr
highlight link SignColumn LineNr

" highlight group for vertical split {{{2

highlight clear VertSplit
highlight VertSplit ctermfg=white ctermbg=gray guifg=#fafafa guibg=#666666

" highlight groups for plugins {{{2
" Asynchronous Lint Engine | w0rp/ale {{{3

highlight clear ALEError
highlight clear ALEErrorSign
highlight clear ALEVirtualTextError
highlight clear ALEInfo
highlight clear ALEInfoSign
highlight clear ALEVirtualTextInfo
highlight clear ALEStyleError
highlight clear ALEStyleErrorSign
highlight clear ALEVirtualTextStyleError
highlight clear ALEStyleWarning
highlight clear ALEStyleWarningSign
highlight clear ALEVirtualTextStyleWarning
highlight clear ALEWarning
highlight clear ALEWarningSign
highlight clear ALEVirtualTextWarning
highlight ALEError            cterm=underline ctermfg=203 gui=underline guisp=#f44336
highlight ALEErrorSign        ctermfg=231     ctermbg=203 guifg=#fafafa guibg=#f44336
highlight link ALEVirtualTextError ALEErrorSign
highlight ALEInfo             cterm=underline ctermfg=39  gui=underline guisp=#03a9f4
highlight ALEInfoSign         ctermfg=231     ctermbg=39  guifg=#fafafa guibg=#03a9f4
highlight link ALEVirtualTextInfo ALEInfoSign
highlight ALEStyleError       cterm=underline ctermfg=174 gui=underline guisp=#e57373
highlight ALEStyleErrorSign   ctermfg=231     ctermbg=174 guifg=#fafafa guibg=#e57373
highlight link ALEVirtualTextStyleError ALEStyleErrorSign
highlight ALEStyleWarning     cterm=underline ctermfg=215 gui=underline guisp=#ffb74d
highlight ALEStyleWarningSign ctermfg=231     ctermbg=215 guifg=#fafafa guibg=#ffb74d
highlight link ALEVirtualTextStyleWarning ALEStyleWarningSign
highlight ALEWarning          cterm=underline ctermfg=208 gui=underline guisp=#ff9800
highlight ALEWarningSign      ctermfg=231     ctermbg=208 guifg=#fafafa guibg=#ff9800
highlight link ALEVirtualTextWarning ALEWarningSign

" LanguageClient-neovim | autozimu/LanguageClient-neovim {{{3

highlight clear LanguageClientHint
highlight clear LanguageClientHintSign
highlight clear LanguageClientHintVirtualText
highlight LanguageClientHint     cterm=underline ctermfg=75 gui=underline guisp=#64b5f6
highlight LanguageClientHintSign ctermfg=231     ctermbg=75 guifg=#fafafa guibg=#64b5f6
highlight link LanguageClientHintVirtualText LanguageClientHintSign

" Signify | mhinz/vim-signify {{{3

" highlights for signs
highlight clear SignifySignAdd
highlight clear SignifySignChange
highlight clear SignifySignChangeDelete
highlight clear SignifySignDelete
highlight clear SignifySignDeleteFirstLine
highlight SignifySignAdd          ctermfg=241 ctermbg=185 guifg=#666666 guibg=#cddc39
highlight SignifySignChange       ctermfg=241 ctermbg=227 guifg=#666666 guibg=#ffeb3b
highlight SignifySignChangeDelete ctermfg=241 ctermbg=214 guifg=#666666 guibg=#ffc107
highlight SignifySignDelete       ctermfg=241 ctermbg=216 guifg=#666666 guibg=#ffab91
highlight link SignifySignDeleteFirstLine SignifySignDelete

" highlights for lines
highlight clear SignifyLineAdd
highlight clear SignifyLineChange
highlight clear SignifyLineChangeDelete
highlight clear SignifyLineDelete
highlight clear SignifyLineDeleteFirstLine
highlight SignifyLineAdd          ctermbg=193 guibg=#f0f4c3
highlight SignifyLineChange       ctermbg=229 guibg=#fff9c4
highlight SignifyLineChangeDelete ctermbg=222 guibg=#ffe082
highlight SignifyLineDelete       ctermbg=216 guibg=#ffccbc
highlight link SignifyLineDeleteFirstLine SignifyLineDelete
