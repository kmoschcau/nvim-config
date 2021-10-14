" vim: foldmethod=marker foldlevel=0
" Sets the character encoding used inside Vim.
set encoding=utf-8
scriptencoding utf-8

" vim-polyglot | sheerun/vim-polyglot {{{1
" this has to be done here, otherwise polyglot doesn't realize

" Disable the typescript lang, because the indenting of comments is atrocious.
" And it breaks gq.
let g:polyglot_disabled = ['typescript']

" tmux specific settings {{{1
" if in tmux
if !has('nvim') && &term =~# '^tmux'
  " set the terminal to an xterm color terminal
  set term=xterm-256color
endif

" path settings {{{1

" set the paths for python executables in neovim
if has('nvim')
  if has('win32')
    let s:python2_path = expand('C:/Python27/python')
    let s:python3_path = expand('C:/Python37/python')
  else
    let s:python2_path = expand('$HOME/.pyenv/versions/neovim2/bin/python')
    let s:python3_path = expand('$HOME/.pyenv/versions/neovim3/bin/python')
  endif
  if executable(s:python2_path)
    let g:python_host_prog  = s:python2_path
  endif
  if executable(s:python3_path)
    let g:python3_host_prog = s:python3_path
  endif
endif

" plugins and packages {{{1
if has('nvim-0.5.0')
  " bootstrap packer
  lua require('packer.bootstrap')

  " load the plugin configuration files
  lua require('plugins.config')
endif

" general Vim settings {{{1
" non option settings {{{2

" Switch on syntax highlighting.
if has('nvim') || has('syntax')
  syntax enable
endif

" appearance settings {{{2

" When on, uses |highlight-guifg| and |highlight-guibg| attributes in the
" terminal (thus using 24-bit color). Requires a ISO-8613-3 compatible terminal.
"
" Note: https://bruinsslot.jp/post/how-to-enable-true-color-for-neovim-tmux-and-gnome-terminal/
if has('unix')
  let s:terminfo_colors = substitute(system('tput colors'), '\n\+$', '', '')
else
  " This is a crude check for Windows Terminal, but the only one available right
  " now.
  if exists('$WT_SESSION')
    let s:terminfo_colors = '256'
  else
    let s:terminfo_colors = ''
  endif
endif
if s:terminfo_colors ==# '256' && (has('nvim') || has('termguicolors'))
  set termguicolors
endif

" Syntax settings {{{3
" Java {{{4

" Highlight java.lang.* Identifiers
let g:java_highlight_java_lang_ids = 1

" Highlight functions and some other minor things
let g:java_highlight_functions = 'style'

" Highlight statements, that should only be used for debugging
let g:java_highlight_debug = 1

" Colorscheme settings {{{3

" When set to "dark", Vim will try to use colors that look good on a dark
" background.  When set to "light", Vim will try to use colors that look good on
" a light background.
set background=light

if s:terminfo_colors ==# '256'
  try
    colorscheme material
  catch /^Vim(colorscheme):E185/
    echom '"material" colorscheme not found, using "morning" instead.'
    silent! colorscheme morning
  endtry
else
  silent! colorscheme morning
endif

" Vim terminal options {{{2

" When Vim enters Insert mode the 't_SI' escape sequence is sent. When Vim
" enters Replace mode the 't_SR' escape sequence is sent if it is set, otherwise
" 't_SI' is sent. When leaving Insert mode or Replace mode 't_EI' is used. This
" can be used to change the shape or color of the cursor in Insert or Replace
" mode. These are not standard termcap/terminfo entries, you need to set them
" yourself.
" Example for an xterm, this changes the color of the cursor:
"   if &term =~ "xterm"
"     let &t_SI = "\<Esc>]12;purple\x7"
"     let &t_SR = "\<Esc>]12;red\x7"
"     let &t_EI = "\<Esc>]12;blue\x7"
"   endif
" NOTE: When Vim exits the shape for Normal mode will remain.  The shape from
" before Vim started will not be restored.
if !has('nvim') && &term =~? 'xterm'
  let &t_SI = "\<Esc>[5 q"
  if has('t_SR')
    let &t_SR = "\<Esc>[3 q"
  endif
  let &t_EI = "\<Esc>[1 q"
endif

" Vim options {{{2

" Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.  This
" is a list of items, separated by commas.
set backspace=indent,eol,start

" Specifies for which events the bell will not be rung. It is a comma separated
" list of items. For each item that is present, the bell will be silenced. This
" is most useful to specify specific events in insert mode to be silenced.
set belloff=backspace,cursor,esc

" Every wrapped line will continue visually indented (same amount of space as
" the beginning of that line), thus preserving horizontal blocks of text.
if has('nvim') || has('linebreak')
  set breakindent
endif

" Settings for 'breakindent'. It can consist of the following optional items and
" must be separated by a comma.
if has('nvim') || has('breakindentopt')
  set breakindentopt=shift:2,sbr
endif

" A comma separated list of screen columns that are highlighted with
" hl-ColorColumn. The screen column can be an absolute number, or a number
" preceded with '+' or '-', which is added to or subtracted from 'textwidth'.
if has('nvim') || has('syntax')
  set colorcolumn=+1
endif

" A comma separated list of options for Insert mode completion.
"
"   menu     Use a popup menu to show the possible completions. The menu is only
"            shown when there is more than one match and sufficient colors are
"            available.
"
"   menuone  Use the popup menu also when there is only one match. Useful when
"            there is additional information about the match, e.g., what file it
"            comes from.
"
"   longest  Only insert the longest common text of the matches. If the menu is
"            displayed you can use CTRL-L to add more characters. Whether case is
"            ignored depends on the kind of completion. For buffer text the
"            'ignorecase' option is used.
"
"   preview  Show extra information about the currently selected completion in
"            the preview window. Only works in combination with "menu" or
"            "menuone".
"
"   (Vim only)
"   popup    Show extra information about the currently selected
"            completion in a popup window.  Only works in combination
"            with "menu" or "menuone".  Overrides "preview".
"            See |'completepopup'| for specifying properties.
"            {only works when compiled with the |+textprop| feature}
"
"   (Vim only)
"   popuphidden
"            Just like "popup" but initially hide the popup.  Use a
"            |CompleteChanged| autocommand to fetch the info and call
"            |popup_show()| once the popup has been filled.
"            See the example at |complete-popuphidden|.
"            {only works when compiled with the |+textprop| feature}
"
"   noinsert Do not insert any text for a match until the user selects a match
"            from the menu. Only works in combination with "menu" or "menuone".
"            No effect if "longest" is present.
"
"   noselect Do not select a match in the menu, force the user to select one
"            from the menu. Only works in combination with "menu" or "menuone".
if has('nvim') || has('insert_expand')
  set completeopt=menuone
  if has('textprop')
    set completeopt+=popup
  endif
  if has('patch-7.4.775')
    set completeopt+=noinsert,noselect
  endif
endif

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
set expandtab

" Characters to fill the statuslines and vertical separators.
if has('nvim') || has('folding')
  set fillchars=diff:\ ,vert:\ ,fold:·
endif

" Sets 'foldlevel' when starting to edit another buffer in a window.
if has('nvim') || has('folding')
  set foldlevelstart=99
endif

" This is a sequence of letters which describes how automatic formatting is to
" be done. See fo-table.
set formatoptions=croqlj

" Configures the cursor style for each mode. Works in the GUI and some
" terminals.
" The option is a comma separated list of parts. Each part consists of a
" mode-list and an argument-list:
"   mode-list:argument-list
if has('nvim') || has('gui')
  set guicursor=n:block-blinkwait1000-blinkon500-blinkoff500-Cursor,
               \v:block-blinkon0-Cursor,
               \c:ver20-blinkwait1000-blinkon500-blinkoff500-Cursor,
               \i-ci-sm:ver20-blinkwait1000-blinkon500-blinkoff500-CursorInsert,
               \r-cr:hor10-blinkwait1000-blinkon500-blinkoff500-CursorReplace,
               \o:hor50-Cursor
endif

" A history of ":" commands, and a history of previous search patterns is
" remembered.  This option decides how many entries may be stored in each of
" these histories.
set history=10000

" When there is a previous search pattern, highlight all its matches.
if has('nvim') || has('extra_search')
  set hlsearch
endif

" "nosplit": Shows the effects of a command incrementally, as you type.
" "split"  : Also shows partial off-screen results in a preview window.
if has('nvim')
  set inccommand=split
endif

" While typing a search command, show where the pattern, as it was typed so far,
" matches.  The matched string is highlighted.  If the pattern is invalid or not
" found, nothing is shown.
if has('nvim') || has('extra_search')
  set incsearch
endif

" Insert two spaces after a '.', '?' and '!' with a join command. Otherwise only
" one space is inserted.
set nojoinspaces

" The value of this option influences when the last window will have a status
" line:
"   0: never
"   1: only if there are at least two windows
"   2: always
set laststatus=2

" If on, Vim will wrap long lines at a character in 'breakat' rather than at the
" last character that fits on the screen.
if has('nvim') || has('linebreak')
  set linebreak
endif

" List mode: Show tabs as CTRL-I is displayed, display $ after end of line.
" Useful to see the difference between tabs and spaces and for trailing blanks.
" Further changed by the 'listchars' option.
set list

" Strings to use in 'list' mode and for the |:list| command.  It is a comma
" separated list of string settings.
if has('nvim')
  set listchars=trail:·,extends:≻,precedes:≺,conceal:◌,nbsp:⨯
  if has('nvim-0.6.0') && !has('win32')
    set listchars+=tab:⊳\ ⎹
  elseif has('nvim-0.4.0')
    set listchars+=tab:⊳\ \|
  else
    set listchars+=tab:⊳-
  endif
else
  " Note: Using double width chars in this will make vim and gVim crash when
  "       trying to display them.
  set listchars=trail:·,extends:>,precedes:<,conceal:o,nbsp:x
  if has('vim-patch:8.1.0759')
    set listchars+=tab:>\ \|
  else
    set listchars+=tab:>-
  endif
endif

" The maximum number of combining characters supported for displaying.
if !has('nvim')
  set maxcombine=6
endif

" Enables mouse support.
if has('nvim') || has('mouse')
  set mouse=a
endif

" Sets the model to use for the mouse. The name mostly specifies what the right
" mouse button is used for.
set mousemodel=extend

" Print the line number in front of each line.
set number

" Enables pseudo-transparency for the |popup-menu|. Valid values are in the
" range of 0 for fully opaque popupmenu (disabled) to 100 for fully transparent
" background. Values between 0-30 are typically most useful.
if has('nvim-0.4.0')
  set pumblend=20
endif

" Set modeline enabled, no matter what the system config says.
set modeline

" When using the scroll wheel and this option is set, the window under the mouse
" pointer is scrolled. With this option off the current window is scrolled.
if !has('nvim')
  set scrollfocus
endif

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=0

" Number of spaces to use for each step of (auto)indent. When zero the 'tabstop'
" value will be used. Setting this independently from 'tabstop' allows for tabs
" to be a certain width in characters, but still only indent 'shiftwidth' with
" spaces.
set shiftwidth=2

" This option helps to avoid all the |hit-enter| prompts caused by file
" messages, for example  with CTRL-G, and to avoid some other messages.
set shortmess=ilnrxoOTIcF

" String to put at the start of lines that have been wrapped.
if has('nvim')
  let &showbreak ='↪ '
elseif has('linebreak')
  let &showbreak = '> '
endif

" Show (partial) command in the last line of the screen.
if has('nvim') || has('showcmd') || has('cmdline_info')
  set showcmd
endif

" If in Insert, Replace or Visual mode put a message on the last line.
set noshowmode

" The minimal number of columns to scroll horizontally. Used only when the
" 'wrap' option is off and the cursor is moved off of the screen. When it is
" zero the cursor will be put in the middle of the screen. When using a slow
" terminal set it to a large number or 0. When using a fast terminal use a small
" number or 1.
set sidescroll=1

" When and how to draw the signcolumn.
if has('nvim')
  set signcolumn=auto:9
else
  set signcolumn=auto
endif

" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' or 'softtabstop' is used in other places.  A <BS> will delete a
" 'shiftwidth' worth of space at the start of the line.
set nosmarttab

" When on, splitting a window will put the new window below the current one.
set splitbelow

" When on, splitting a window will put the new window right of the current one.
set splitright

" When "on" the commands listed below move the cursor to the first non-blank of
" the line. When off the cursor is kept in the same column (if possible). This
" applies to the commands: CTRL-D, CTRL-U, CTRL-B, CTRL-F, "G", "H", "M", "L",
" gg, and to the commands "d", "<<" and ">>" with a linewise operator, with "%"
" with a count and to buffer changing commands (CTRL-^, :bnext, :bNext, etc.).
" Also for an Ex command that only has a line number, e.g., ":25" or ":+".
" In case of buffer changing commands the cursor is placed at the column where
" it was the last time the buffer was edited.
set startofline

" statusline {{{3
if has('nvim') || has('statusline')
  " helper methods {{{4
  " current mode {{{5
  " Dictionary: take mode() input -> longer notation of current mode
  " mode() is defined by Vim
  let g:currentmode = { 'n'  : 'NORMAL',
                      \ 'no' : 'N-OPERATOR PENDING',
                      \ 'v'  : 'VISUAL',
                      \ 'V'  : 'V-LINE',
                      \ '' : 'V-BLOCK',
                      \ 's'  : 'SELECT',
                      \ 'S'  : 'S-LINE',
                      \ '' : 'S-BLOCK',
                      \ 'i'  : 'INSERT',
                      \ 'R'  : 'REPLACE',
                      \ 'Rv' : 'V-REPLACE',
                      \ 'c'  : 'COMMAND',
                      \ 'cv' : 'VIM EX',
                      \ 'ce' : 'EX',
                      \ 'r'  : 'PROMPT',
                      \ 'rm' : 'MORE',
                      \ 'r?' : 'CONFIRM',
                      \ '!'  : 'SHELL',
                      \ 't'  : 'TERMINAL' }

  " Function: return current mode
  " abort -> function will abort soon as error detected
  function! ModeCurrent() abort
    return get(g:currentmode, mode())
  endfunction
  " }}}4

  " When nonempty, this option determines the content of the status line.

  " first, empty the statusline
  set statusline=

  " show the current mode
  " left justified, minimum 7
  let &statusline .= ' %-7.{ModeCurrent()}'

  " group for buffer flags
  " %h: Help buffer flag, text is "[help]".
  " %w: Preview window flag, text is "[Preview]".
  " %q: "[Quickfix List]", "[Location List]" or empty.
  " left justified
  let &statusline .= ' %-(%h%w%q%)'

  " Path to the file in the buffer, as typed or relative to current directory
  " left justified, maximum 100
  let &statusline .= ' %-.100f'

  " Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
  let &statusline .= '%m'

  " Separation point between alignment sections. Each section will be separated
  " by an equal number of spaces. No width fields allowed.
  let &statusline .= '%='

  " Type of file in the buffer, e.g., "[vim]".  See 'filetype'.
  " maximum 20
  let &statusline .= '%.20y '

  " Percentage through file in lines as in CTRL-G.
  " minimum 3, followed by a literal percent sign
  let &statusline .= '%3p%% '

  " %l: Line number.
  " %L: Number of lines in buffer.
  let &statusline .= '%l/%L '

  " Column number and virtual column number, if different.
  " preceded by a literal ': ', minimum 5
  let &statusline .= ': %5(%c%V%) '
endif
" }}}3

" Maximum number of tab pages to be opened by the |-p| command line argument or
" the ":tab all" command.
set tabpagemax=50

" Number of spaces that a <Tab> in the file counts for. This just sets it to the
" default value, because polyglot likes to set it to 2 for simple text files for
" some reason.
set tabstop=8

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
set textwidth=80

" When on, the title of the window will be set to the value of 'titlestring' (if
" it is not empty), or to: filename [+=-] (path) - NVIM
if has('nvim') || has('title')
  set title
endif

" This option will be used for the window title when exiting Vim if the original
" title cannot be restored.  Only happens if 'title' is on or 'titlestring' is
" not empty.
if has('nvim') || has('title')
  set titleold=
endif

" If this many milliseconds nothing is typed the swap file will be written to
" disk. Also used for the CursorHold autocommand event.
set updatetime=100

" When 'wildmenu' is on, command-line completion operates in an enhanced mode.
" On pressing 'wildchar' (usually <Tab>) to invoke completion, the possible
" matches are shown just above the command line, with the first match
" highlighted (overwriting the status line, if there is one).  Keys that show
" the previous/next match, such as <Tab> or CTRL-P/CTRL-N, cause the highlight
" to move to the appropriate match.
if has('nvim') || has('wildmenu')
  set wildmenu
endif

" Completion mode that is used for the character specified with 'wildchar'. It
" is a comma separated list of up to four parts. Each part specifies what to do
" for each consecutive use of 'wildchar'. The first part specifies the behavior
" for the first use of 'wildchar', The second part for the second use, etc.
set wildmode=longest:full

" A list of words that change how command line completion is done.
if has('nvim-0.4.0')
  set wildoptions=pum
endif

" autocommands {{{2

augroup InitVim
  autocmd!
  " Do not show line numbers in terminal buffers
  if has('nvim')
    autocmd TermOpen * setlocal nonumber norelativenumber
  else
    autocmd TerminalOpen * setlocal nonumber norelativenumber
  endif
augroup end

" key maps {{{2

" Make "Y" key in normal mode behave more logical and analoguous to "C" and "D".
nnoremap Y y$

" Add a debugging command for syntax highlighting
function! SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  if exists(':OmniSharpHighlightEcho')
    echon ' | '
    OmniSharpHighlightEcho
  endif
  if exists(':TSHighlightCapturesUnderCursor')
    TSHighlightCapturesUnderCursor
  endif
endfunction
nnoremap <F10> :call SynStack()<cr>

" plugin key maps {{{3
" ale | dense-analysis/ale {{{4

nmap <silent> <C-l>d <Plug>(ale_detail)

" coc.nvim | neoclide/coc.nvim {{{4

inoremap <silent><expr> <C-space> coc#refresh()
nnoremap <silent>       K         :call CocAction('doHover')<cr>
nnoremap <silent>       <C-s>d    :call CocAction('jumpDefinition')<cr>
nnoremap <silent>       <C-s>D    :call CocAction('jumpDefinition', v:false)<cr>
nnoremap <silent>       <C-s>t    :call CocAction('jumpTypeDefinition')<cr>
nnoremap <silent>       <C-s>T    :call CocAction('jumpTypeDefinition', v:false)<cr>
nnoremap <silent>       <C-s>i    :call CocAction('jumpImplementation')<cr>
nnoremap <silent>       <C-s>I    :call CocAction('jumpImplementation', v:false)<cr>
nnoremap <silent>       <C-s>r    :call CocAction('jumpReferences')<cr>
nnoremap <silent>       <C-s>R    :call CocAction('jumpReferences', v:false)<cr>
nmap     <silent>       <C-s>n    <Plug>(coc-rename)
nmap     <silent>       <C-s>l    <Plug>(coc-codelens-action)
nmap     <silent>       <C-s>f    <Plug>(coc-float-jump)

" fzf fzf.vim | junegunn/fzf junegunn/fzf.vim {{{4

" Open FZF with the Ctrl-p map
nnoremap <C-p> :Files<cr>

" Change the default FZF maps
let g:fzf_action = { 'ctrl-t' : 'tab split',
                   \ 'ctrl-s' : 'split',
                   \ 'ctrl-v' : 'vsplit' }

" gundo | sjl/gundo.vim {{{4

nnoremap <silent> <F5> :GundoToggle<CR>

" vim-markdown | plasticboy/vim-markdown {{{4

" Disable 'ge' motion override.
map <Plug> <Plug>Markdown_EditUrlUnderCursor

" vim-wordmotion | chaoren/vim-wordmotion {{{4

let g:wordmotion_mappings = {
      \ 'w' : '<M-w>',
      \ 'b' : '<M-b>',
      \ 'e' : '<M-e>',
      \ 'ge' : 'g<M-e>',
      \ 'aw' : 'a<M-w>',
      \ 'iw' : 'i<M-w>'
      \ }

" vimspector | puremourning/vimspector {{{4

nmap <silent> <M-v>c <Plug>VimspectorContinue
nmap <silent> <M-v>p <Plug>VimspectorPause
nmap <silent> <M-v>s <Plug>VimspectorStop
nmap <silent> <M-v>R :VimspectorReset<cr>
nmap <silent> <M-v>b <Plug>VimspectorToggleBreakpoint
nmap <silent> <M-v>B <Plug>VimspectorToggleConditionalBreakpoint
nmap <silent> <M-v>r <Plug>VimspectorRunToCursor
nmap <silent> <M-v>o <Plug>VimspectorStepOver
nmap <silent> <M-v>i <Plug>VimspectorStepInto
nmap <silent> <M-v>u <Plug>VimspectorStepOut
nmap <silent> <M-v>e <Plug>VimspectorBalloonEval
vmap <silent> <M-v>e <Plug>VimspectorBalloonEval

" plugin configurations {{{1
" SimpylFold | tmhedberg/SimpylFold {{{2

" Preview docstrings in fold text.
let g:SimpylFold_docstring_preview = 1

" ale | dense-analysis/ale {{{2

" This variable defines the format of the echoed message. The `%s` is the error
" message itself, and it can contain the following handlers:
" - `%linter%` for linter's name
" - `%severity%` for the type of severity
let g:ale_echo_msg_format = '%linter%: %severity% - %s'

" The sign for errors in the sign gutter.
let g:ale_sign_error = '‼ '

" The sign for "info" markers in the sign gutter.
let g:ale_sign_info = '¡ '

" The sign for style errors in the sign gutter.
let g:ale_sign_style_error = '‼S'

" The sign for style warnings in the sign gutter.
let g:ale_sign_style_warning = '!S'

" The sign for warnings in the sign gutter.
let g:ale_sign_warning = '! '

" Enable the virtualtext error display.
let g:ale_virtualtext_cursor = 1

" coc.nvim | neoclide/coc.nvim {{{2

augroup CocNvim_InitVim
  autocmd!
  " Show method signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " Show the location list without opening the preview by default.
  autocmd User CocLocationsChange CocList --normal location
augroup end

" Disable the default locationlist with preview.
let g:coc_enable_locationlist = 0

let g:coc_global_extensions = [
      \'coc-java',
      \'coc-java-debug',
      \'coc-json',
      \'coc-omnisharp',
      \'coc-pyright',
      \'coc-rls',
      \'coc-sh',
      \'coc-solargraph',
      \'coc-tsserver',
      \'coc-vimlsp',
      \'coc-yaml'
      \]

" csv.vim | chrisbra/csv.vim {{{2

" do not conceal delimiters
let g:csv_no_conceal = 1

" fzf fzf.vim | junegunn/fzf junegunn/fzf.vim {{{2

" Set FZF default command. Usually this is set in the shell, but setting it here
" helps with FZF integration on Windows.
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob !/.git/'
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --files-with-matches --hidden'
endif

" Customize the FZF colors
let g:fzf_colors = {
    \ 'fg':         ['fg', 'Material_VimNormal'],
    \ 'bg':         ['bg', 'Material_VimNormal'],
    \ 'hl':         ['fg', 'Material_SynSpecial'],
    \ 'fg+':        ['fg', 'Material_VimNormal'],
    \ 'bg+':        ['bg', 'Material_VimVisual'],
    \ 'hl+':        ['fg', 'Material_SynSpecial'],
    \ 'preview-fg': ['fg', 'Material_VimNormal'],
    \ 'preview-bg': ['bg', 'Material_VimNormal'],
    \ 'gutter':     ['bg', 'Material_VimLightFramingSubtleFg'],
    \ 'pointer':    ['fg', 'Material_VimNormal'],
    \ 'marker':     ['bg', 'Material_VimInfoInverted'],
    \ 'border':     ['bg', 'Material_VimStrongFramingWithoutFg'],
    \ 'info':       ['fg', 'Material_VimMoreMsg'],
    \ 'prompt':     ['bg', 'Material_VimStatusLine']
    \ }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up.
let g:fzf_history_dir = '~/.local/share/fzf/history'

" gundo | sjl/gundo.vim {{{2

" Set this to 0 to disable the help text in the Gundo graph window.
let g:gundo_help = 0

" Set this to 0 to disable automatically rendering preview diffs as you move
" through the undo tree (you can still render a specific diff with r).  This can
" be useful on large files and undo trees to speed up Gundo.
let g:gundo_auto_preview = 0

" nerdtree | preservim/nerdtree {{{2

" If set to 1, the NERD tree window will close after opening a file with the
" |NERDTree-o|, |NERDTree-i|, |NERDTree-t| and |NERDTree-T| mappings.
let g:NERDTreeQuitOnOpen = 1

" This option tells Vim whether to display hidden files by default.
let g:NERDTreeShowHidden = 1

" This setting disables the 'Bookmarks' label 'Press ? for help' text.
" This does not seem to work.
let g:NERDTreeMinimalUI = 1

" nvim-treesitter | nvim-treesitter/nvim-treesitter {{{2

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" omnisharp-vim | Omnisharp/omnisharp-vim {{{2

" Have OmniSharp always highlight
let g:Omnisharp_highlighting = 3

" packer.nvim | wbthomason/packer.nvim {{{2

augroup PackerNvim_InitVim
  autocmd!

  autocmd BufWritePost ~/.config/nvim/lua/plugins/init.lua source <afile> | PackerCompile
augroup end
" vim-airline | vim-airline/vim-airline {{{2
" airline options {{{3

" By default, airline will use unicode symbols if your encoding matches utf-8.
" If you want the powerline symbols set this variable.
let g:airline_powerline_fonts = 1

" airline extension options {{{3

" Rather opt in to extensions instead of loading all at the start.
let g:airline_extensions = [
    \   'ale',
    \   'branch',
    \   'csv',
    \   'fugitiveline',
    \   'fzf',
    \   'hunks',
    \   'omnisharp',
    \   'quickfix',
    \   'term',
    \   'whitespace',
    \   'wordcount',
    \ ]


" airline-branch {{{4

" Truncate long branch names to a fixed length.
let g:airline#extensions#branch#displayed_head_limit = 15

" Truncate all path sections but the last one of branch names.
let g:airline#extensions#branch#format = 2

" airline-csv {{{4

" Show the name of columns. (Leads to wrong output, if no headers are
" available.)
let g:airline#extensions#csv#column_display = 'Name'

" airline-default {{{4

" Set which sections get truncated and at what width.
" Basic concept here is that there should be 20 characters available for the
" file name. Anything else appears in order of importance.
" The min width for this is 27 characters
" Widths for sections under most common circumstances:
" a:        9
" b:       12 + branch name
"               (starts to disappear at 101, fully gone at 79)
" x:        2 + filetype name
" y:       13
" z:       24
" warning: 12 when showing errors
" error:   12 when showing errors
let g:airline#extensions#default#section_truncate_width = { 'a'       : 88,
                                                          \ 'b'       : 79,
                                                          \ 'x'       : 73,
                                                          \ 'y'       : 66,
                                                          \ 'z'       : 53,
                                                          \ 'warning' : 29,
                                                          \ 'error'   : 28 }

" Set the layout of the sections. Left side being in the first array, right
" side in the second.
let g:airline#extensions#default#layout = [['a', 'b', 'c'],
                                         \ ['x', 'y', 'z', 'warning', 'error']]

" airline-hunks {{{4

" Enable showing only non-zero hunks.
let g:airline#extensions#hunks#non_zero_only = 1

" airline-whitespace {{{4

" Customize the type of mixed indent checking to perform.
"   spaces are allowed after tabs, but not in between
"   this algorithm works well with programming styles that use tabs for
"   indentation and spaces for alignment
let g:airline#extensions#whitespace#mixed_indent_algo = 2

" configure, which filetypes have special treatment of /* */ comments,
" matters for mix-indent-file algorithm
let g:airline#extensions#c_like_langs =
    \ ['arduino', 'c', 'cpp', 'cuda', 'go', 'java', 'javascript', 'ld', 'php']

" vim-devicons | ryanoasis/vim-devicons {{{2

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1

" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" vim-javascript | pangloss/vim-javascript {{{2

" Enable JSDoc syntax highlighting.
let g:javascript_plugin_jsdoc = 1

" vim-markdown | plasticboy/vim-markdown {{{2

" Fold like in python-mode (meaning, include headers as the first line of a
" fold.
let g:vim_markdown_folding_style_pythonic = 1

" Change the indent level of new list items to two spaces.
let g:vim_markdown_new_list_item_indent = 2

" vim-markdown-composer | euclio/vim-markdown-composer {{{2

" Whether the server should automatically start when a markdown file is opened.
let g:markdown_composer_autostart = 0

" vim-nerdtree-syntax-highlight | tiagofumo/vim-nerdtree-syntax-highlight {{{2

" enables folder icon highlighting using exact match
let g:NERDTreeHighlightFolders = 1

" vim-ruby | vim-ruby/vim-ruby {{{2

" Use the "do" indentation style, since it better conforms to the Ruby style
" guide.
let g:ruby_indent_block_style = 'do'

" Highlight operators and pseudo operators.
let g:ruby_operators = 1
let g:ruby_pseudo_operators = 1

" Enable syntax based folding for Ruby files.
let g:ruby_fold = 1

" Specify what can be folded.
let g:ruby_foldable_groups = 'def class module # __END__ do'

" vim-signify | mhinz/vim-signify {{{2

" Which VCS to check for
let g:signify_vcs_list = ['git']

" Enable more aggressive sign update.
let g:signify_realtime = 1

" Update signs when entering a buffer that was modified.
let g:signify_update_on_bufenter = 1

" Update the signs on FocusGained.
let g:signify_update_on_focusgained = 1

" Reconfigure the sign text used.
let g:signify_sign_change = '~'

" Additionally trigger sign updates in normal or insert mode after 'updatetime'
" milliseconds without any keypresses.
let g:signify_cursorhold_normal = 1
let g:signify_cursorhold_insert = 1
