" Vim: set foldmethod=marker:
scriptencoding=utf-8

" path settings {{{1

if has('win32')
  " set the paths for the python executables (installed with chocolatey)
  let g:python_host_prog  = 'C:/Python27/python'
  let g:python3_host_prog = 'C:/Python37/python'
else
  if executable(expand('$HOME/.pyenv/versions/neovim2/bin/python'))
    let g:python_host_prog  = expand('$HOME/.pyenv/versions/neovim2/bin/python')
  endif
  if executable(expand('$HOME/.pyenv/versions/neovim3/bin/python'))
    let g:python3_host_prog = expand('$HOME/.pyenv/versions/neovim3/bin/python')
  endif
endif

" vim-plug | junegunn/vim-plug {{{1

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
if has('win32')
  call plug#begin('~/AppData/Local/nvim-data/plugged')
else
  call plug#begin('~/.local/share/nvim/plugged')
endif

" build helper functions {{{2
" vim-markdown-composer helper function {{{3
function! BuildComposer(info)
  if a:info.status !=# 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction

" general plugins {{{2

" Make sure you use single quotes

" Plugins which do not work under Windows (yet).
if !has('win32')
  Plug 'euclio/vim-markdown-composer', { 'do' : function('BuildComposer') }
  Plug 'itmammoth/run-rspec.vim'
  Plug 'junegunn/fzf', { 'dir' : '~/.fzf' }
  Plug 'junegunn/fzf.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'neoclide/coc.nvim', { 'do' : 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-eslint', { 'do' : 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-java', { 'do' : 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-json', { 'do' : 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-python', { 'do' : 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-rls', { 'do' : 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-solargraph', { 'do' : 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-yaml', { 'do' : 'yarn install --frozen-lockfile' }
endif

Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'NLKNguyen/vim-maven-syntax'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ap/vim-css-color'
Plug 'chaoren/vim-wordmotion'
Plug 'chrisbra/csv.vim'
Plug 'dag/vim-fish'
Plug 'dense-analysis/ale'
Plug 'embear/vim-localvimrc'
Plug 'godlygeek/tabular'
Plug 'hail2u/vim-css3-syntax'
Plug 'infoslack/vim-docker'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lepture/vim-velocity'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mhinz/vim-signify'
Plug 'noprompt/vim-yardoc'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown' " depends on godlygeek/tabular
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'slim-template/vim-slim'
Plug 'tmhedberg/SimpylFold'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-ruby/vim-ruby'

" }}}2

" Initialize plugin system
call plug#end()

" general Vim settings {{{1
" non option settings {{{2

" Switch on syntax highlighting.
syntax enable

" appearance settings {{{2

" When on, uses |highlight-guifg| and |highlight-guibg| attributes in the
" terminal (thus using 24-bit color). Requires a ISO-8613-3 compatible terminal.
"
" Note: https://bruinsslot.jp/post/how-to-enable-true-color-for-neovim-tmux-and-gnome-terminal/
let s:terminfo_colors = substitute(system('tput colors'), '\n\+$', '', '')
if s:terminfo_colors ==# '256'
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
  colorscheme material
else
  colorscheme morning
endif

" Vim options {{{2

" Every wrapped line will continue visually indented (same amount of space as
" the beginning of that line), thus preserving horizontal blocks of text.
set breakindent

" Settings for 'breakindent'. It can consist of the following optional items and
" must be separated by a comma.
set breakindentopt=shift:2,sbr

" A comma separated list of screen columns that are highlighted with
" hl-ColorColumn. The screen column can be an absolute number, or a number
" preceded with '+' or '-', which is added to or subtracted from 'textwidth'.
set colorcolumn=+1

" A comma separated list of options for Insert mode completion.
"
"   menu    Use a popup menu to show the possible completions. The menu is only
"           shown when there is more than one match and sufficient colors are
"           available.

"   menuone Use the popup menu also when there is only one match. Useful when
"           there is additional information about the match, e.g., what file it
"           comes from.

"   longest Only insert the longest common text of the matches. If the menu is
"           displayed you can use CTRL-L to add more characters. Whether case is
"           ignored depends on the kind of completion. For buffer text the
"           'ignorecase' option is used.

"   preview Show extra information about the currently selected completion in
"           the preview window. Only works in combination with "menu" or
"           "menuone".

"   noinsert Do not insert any text for a match until the user selects a match
"            from the menu. Only works in combination with "menu" or "menuone".
"            No effect if "longest" is present.

"   noselect Do not select a match in the menu, force the user to select one
"            from the menu. Only works in combination with "menu" or "menuone".
set completeopt=menu,menuone,preview,noinsert,noselect

" Do include whitespace after a word with a 'cw' command to be more in line with
" 'chaoren/vim-wordmotion'.
set cpoptions-=_

" Use the column for 'number' and 'relativenumber' for wrapped text as well.
set cpoptions+=n

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
set expandtab

" Characters to fill the statuslines and vertical separators.
set fillchars=diff:\ ,vert:\ ,fold:-

" This is a sequence of letters which describes how automatic formatting is to
" be done. See fo-table.
set formatoptions=croqlj

" Configures the cursor style for each mode. Works in the GUI and some
" terminals.
" The option is a command separated list of parts. Each part consists of a
" mode-list and an argument-list:
"   mode-list:argument-list
set guicursor=n-c:block-blinkwait1000-blinkon500-blinkoff500
            \,v-sm:block-blinkwait0
            \,i-ci:ver75-blinkwait1000-blinkon500-blinkoff500
            \,ve:ver100-blinkwait0
            \,r-cr:hor75-blinkwait1000-blinkon500-blinkoff500
            \,o:hor100-blinkwait0

" Insert two spaces after a '.', '?' and '!' with a join command. Otherwise only
" one space is inserted.
set nojoinspaces

" If on, Vim will wrap long lines at a character in 'breakat' rather than at the
" last character that fits on the screen.
set linebreak

" List mode: Show tabs as CTRL-I is displayed, display $ after end of line.
" Useful to see the difference between tabs and spaces and for trailing blanks.
" Further changed by the 'listchars' option.
set list

" Strings to use in 'list' mode and for the |:list| command.  It is a comma
" separated list of string settings.
set listchars=tab:⊢-,trail:·,extends:›,precedes:‹,conceal:◌,nbsp:⨯

" Enables mouse support.
set mouse=a

" Print the line number in front of each line.
set number

" Enables pseudo-transparency for the |popup-menu|. Valid values are in the
" range of 0 for fully opaque popupmenu (disabled) to 100 for fully transparent
" background. Values between 0-30 are typically most useful.
set pumblend=20

" Number of spaces to use for each step of (auto)indent. When zero the 'tabstop'
" value will be used. Setting this independently from 'tabstop' allows for tabs
" to be a certain width in characters, but still only indent 'shiftwidth' with
" spaces.
set shiftwidth=2

" String to put at the start of lines that have been wrapped.
set showbreak=↪

" Show (partial) command in the last line of the screen.
set showcmd

" If in Insert, Replace or Visual mode put a message on the last line.
set noshowmode

" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' or 'softtabstop' is used in other places.  A <BS> will delete a
" 'shiftwidth' worth of space at the start of the line.
set nosmarttab

" When on, splitting a window will put the new window below the current one.
set splitbelow

" When on, splitting a window will put the new window right of the current one.
set splitright

" statusline {{{3
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

" Separation point between alignment sections. Each section will be separated by
" an equal number of spaces. No width fields allowed.
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

" Column number and virtual column number, if diffrent.
" preceded by a literal ': ', minimum 5
let &statusline .= ': %5(%c%V%) '
" }}}3

" Number of spaces that a <Tab> in the file counts for.
set tabstop=2

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
set textwidth=80

" When on, the title of the window will be set to the value of 'titlestring' (if
" it is not empty), or to: filename [+=-] (path) - NVIM
set title

" If this many milliseconds nothing is typed the swap file will be written to
" disk. Also used for the CursorHold autocommand event.
set updatetime=100

" Completion mode that is used for the character specified with 'wildchar'. It
" is a comma separated list of up to four parts. Each part specifies what to do
" for each consecutive use of 'wildchar'. The first part specifies the behavior
" for the first use of 'wildchar', The second part for the second use, etc.
set wildmode=longest:full

" A list of words that change how command line completion is done.
"   tagfile When using CTRL-D to list matching tags, the kind of tag and the
"           file of the tag is listed.  Only one match is displayed per line.
"           Often used tag kinds are:
"             d #define
"             f function
"   pum     Display the completion matches using the popupmenu in the same style
"           as the |ins-completion-menu|.
set wildoptions=pum

" key bindings {{{2

" Make "Y" key in normal mode behave more logical and analoguous to "C" and "D".
nnoremap Y y$

" Add a debugging command for syntax highlighting
function! SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <F10> :call SynStack()<cr>

" coc.nvim | neoclide/coc.nvim {{{3

inoremap <silent><expr> <C-space>  coc#refresh()
nnoremap <silent>       K          :call CocAction('doHover')<cr>
nmap     <silent>       <C-s>d     <Plug>(coc-definition)
nmap     <silent>       <C-s>t     <Plug>(coc-type-definition)
nmap     <silent>       <C-s>i     <Plug>(coc-implementation)
nmap     <silent>       <C-s>r     <Plug>(coc-references)
nmap     <silent>       <C-s>n     <Plug>(coc-rename)
nmap     <silent>       <C-s>l     <Plug>(coc-codelens-action)
nmap     <silent>       <C-s>f     <Plug>(coc-float-jump)

" fzf.vim | junegunn/fzf.vim {{{3

" Open FZF with the Ctrl-p binding
nnoremap <C-p> :FZF<cr>

" Change the default FZF bindings
let g:fzf_action = { 'ctrl-t' : 'tab split',
                   \ 'ctrl-s' : 'split',
                   \ 'ctrl-v' : 'vsplit' }

" Vim Markdown | plasticboy/vim-markdown {{{3

" Disable 'ge' motion override.
map <Plug> <Plug>Markdown_EditUrlUnderCursor

" NERD tree | scrooloose/nerdtree {{{3

nnoremap <silent> <C-N> :NERDTreeToggle<CR>

" Gundo | sjl/gundo.vim {{{3

nnoremap <silent> <F5> :GundoToggle<CR>

" ALE | w0rp/ale {{{3

nmap <silent> <C-l>d <Plug>(ale_detail)

" CSV | chrisbra/csv.vim {{{1

" do not conceal delimiters
let g:csv_no_conceal = 1

" Asynchronous Lint Engine | dense-analysis/ale {{{1

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

" vim-markdown-composer | euclio/vim-markdown-composer {{{1

" Whether the server should automatically start when a markdown file is opened.
let g:markdown_composer_autostart = 0

" fzf.vim | junegunn/fzf.vim {{{1

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up.
let g:fzf_history_dir = '~/.local/share/fzf/history'

" Signify | mhinz/vim-signify {{{1

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

" vim-javascript | pangloss/vim-javascript {{{1

" Enable JSDoc syntax highlighting.
let g:javascript_plugin_jsdoc = 1

" Vim Markdown | plasticboy/vim-markdown {{{1

" Fold like in python-mode (meaning, include headers as the first line of a
" fold.
let g:vim_markdown_folding_style_pythonic = 1

" Change the indent level of new list items to two spaces.
let g:vim_markdown_new_list_item_indent = 2

" NERD tree | scrooloose/nerdtree {{{1

" Exit Vim when the only open window is NERD tree.
augroup NERDTree_InitVim
  autocmd!
  autocmd BufEnter *
      \   if (winnr("$") == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree())
      \ |   quit
      \ | endif
augroup end

" If set to 1, the NERD tree window will close after opening a file with the
" |NERDTree-o|, |NERDTree-i|, |NERDTree-t| and |NERDTree-T| mappings.
let g:NERDTreeQuitOnOpen = 1

" This option tells Vim whether to display hidden files by default.
let g:NERDTreeShowHidden = 1

" This setting disables the 'Bookmarks' label 'Press ? for help' text.
" This does not seem to work.
let g:NERDTreeMinimalUI = 0

" Gundo | sjl/gundo.vim {{{1

" Set this to 0 to disable the help text in the Gundo graph window.
let g:gundo_help = 0

" Set this to 0 to disable automatically rendering preview diffs as you move
" through the undo tree (you can still render a specific diff with r).  This can
" be useful on large files and undo trees to speed up Gundo.
let g:gundo_auto_preview = 0

" SimpylFold | tmhedberg/SimpylFold {{{1

" Preview docstrings in fold text.
let g:SimpylFold_docstring_preview = 1

" vim-airline | vim-airline/vim-airline {{{1
" airline options {{{2

" By default, airline will use unicode symbols if your encoding matches utf-8.
" If you want the powerline symbols set this variable.
let g:airline_powerline_fonts = 1

" airline extension options {{{2

" Rather opt in to extensions instead of loading all at the start.
let g:airline_extensions = [
    \   'ale',
    \   'branch',
    \   'csv',
    \   'fugitiveline',
    \   'hunks',
    \   'quickfix',
    \   'whitespace',
    \   'wordcount',
    \ ]


" airline-branch {{{3

" Truncate long branch names to a fixed length.
let g:airline#extensions#branch#displayed_head_limit = 15

" Truncate all path sections but the last one of branch names.
let g:airline#extensions#branch#format = 2

" airline-csv {{{3

" Show the name of columns. (Leads to wrong output, if no headers are
" available.)
let g:airline#extensions#csv#column_display = 'Name'

" airline-default {{{3

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

" airline-hunks {{{3

" Enable showing only non-zero hunks.
let g:airline#extensions#hunks#non_zero_only = 1

" airline-whitespace {{{3

" Customize the type of mixed indent checking to perform.
"   spaces are allowed after tabs, but not in between
"   this algorithm works well with programming styles that use tabs for
"   indentation and spaces for alignment
let g:airline#extensions#whitespace#mixed_indent_algo = 2

" vim-ruby | vim-ruby/vim-ruby {{{1

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

