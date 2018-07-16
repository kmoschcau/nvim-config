scriptencoding=utf-8
" Vim: set foldmethod=marker:

" path settings {{{1

if has('win32')
  " set the paths for the python executables (installed with chocolatey)
  let g:python_host_prog  = 'C:/Python27/python'
  let g:python3_host_prog = 'C:/Python36/python'
else
  if executable(expand('$HOME/.pyenv/versions/neovim2/bin/python'))
    let g:python_host_prog  = expand('$HOME/.pyenv/versions/neovim2/bin/python')
  endif
  if executable(expand('$HOME/.pyenv/versions/neovim3/bin/python'))
    let g:python3_host_prog = expand('$HOME/.pyenv/versions/neovim3/bin/python')
  endif
endif

" }}}1

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
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction
" }}}3

" }}}2

" general plugins {{{2

" Make sure you use single quotes

Plug 'NLKNguyen/vim-maven-syntax'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'chaoren/vim-wordmotion'
Plug 'chrisbra/csv.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dag/vim-fish'
Plug 'embear/vim-localvimrc'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'francoiscabrol/ranger.vim' " depends on rbgrouleff/bclose.vim
Plug 'godlygeek/tabular'
Plug 'infoslack/vim-docker'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mattn/webapi-vim'
Plug 'noprompt/vim-yardoc'
Plug 'plasticboy/vim-markdown' " depends on godlygeek/tabular
Plug 'rbgrouleff/bclose.vim'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'

" }}}2

" NyaoVim plugins {{{2

Plug 'rhysd/nyaovim-popup-tooltip'

" }}}2

" color schemes {{{2

Plug 'chriskempson/base16-vim'
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'

" }}}2

" Initialize plugin system
call plug#end()

" }}}1

" general Vim settings {{{1

" non option settings {{{2

" Switch on syntax highlighting.
syntax enable

" }}}2

" appearance settings {{{2

" When on, uses |highlight-guifg| and |highlight-guibg| attributes in the
" terminal (thus using 24-bit color). Requires a ISO-8613-3 compatible terminal.
"
" Note: https://bruinsslot.jp/post/how-to-enable-true-color-for-neovim-tmux-and-gnome-terminal/
set termguicolors

" Colorscheme settings {{{3

" When set to "dark", Vim will try to use colors that look good on a dark
" background.  When set to "light", Vim will try to use colors that look good on
" a light background.
set background=dark

" base16-vim | chriskempson/base16-vim {{{4

" colorscheme base16-default-dark

" }}}4

" oceanic next | mhartington/oceanic-next {{{4

" let g:oceanic_next_terminal_bold   = 1
" let g:oceanic_next_terminal_italic = 1
" let g:airline_theme                = 'oceanicnext'

" colorscheme OceanicNext

" }}}4

" gruvbox | morhetz/gruvbox {{{4

" Enables italic text.
" default: gui 1, term 0
" Note: Set this to 1, just to be sure.
let g:gruvbox_italic = 1

" Inverts GitGutter and Syntastic signs. Useful to rapidly focus on.
" default: 0
let g:gruvbox_invert_signs = 1

" Inverts tabline highlights, providing distinguishable tabline-fill.
" default: 0
let g:gruvbox_invert_tabline = 1

colorscheme gruvbox

" custom highligh groups {{{5

" Overridden highlight group for the cursor (usually done by gnome-terminal)
highlight clear Cursor
highlight Cursor cterm=reverse guifg=#282828 guibg=#fe8019

" Highlight groups for neovim's terminal cursor
highlight! link TermCursor Cursor
highlight clear TermCursorNC
highlight TermCursorNC cterm=reverse guifg=#282828 guibg=#d65d0e

" }}}5

" }}}4

" }}}3

" }}}2

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

" Do include whitespace after a word with a 'cw' command. The desired behaviour
" would be to not do this, but it does not work because of
" 'chaoren/vim-wordmotion' anyway.
set cpoptions-=_

" Use the column for 'number' and 'relativenumber' for wrapped text as well.
set cpoptions+=n

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
set expandtab

" Characters to fill the statuslines and vertical separators.
set fillchars=diff:\ ,fold:-,vert:█

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

" Print the line number in front of each line.
set number

" Number of spaces to use for each step of (auto)indent. When zero the 'tabstop'
" value will be used.
set shiftwidth=0

" String to put at the start of lines that have been wrapped.
set showbreak=↪

" Show (partial) command in the last line of the screen.
set showcmd

" When completing a word in insert mode (see |ins-completion|) from the tags
" file, show both the tag name and a tidied-up form of the search pattern (if
" there is one) as possible matches.  Thus, if you have matched a C function,
" you can see a template for what arguments are required (coding style
" permitting).
set showfulltag

" If in Insert, Replace or Visual mode put a message on the last line.
set noshowmode

" When on, splitting a window will put the new window below the current one.
set splitbelow

" When on, splitting a window will put the new window right of the current one.
set splitright

" statusline {{{3

" helper methods {{{4

" current mode {{{5

" Dictionary: take mode() input -> longer notation of current mode
" mode() is defined by Vim
let g:currentmode={ 'n'  : 'NORMAL',
                 \  'no' : 'N-OPERATOR PENDING',
                 \  'v'  : 'VISUAL',
                 \  'V'  : 'V-LINE',
                 \  '' : 'V-BLOCK',
                 \  's'  : 'SELECT',
                 \  'S'  : 'S-LINE',
                 \  '' : 'S-BLOCK',
                 \  'i'  : 'INSERT',
                 \  'R'  : 'REPLACE',
                 \  'Rv' : 'V-REPLACE',
                 \  'c'  : 'COMMAND',
                 \  'cv' : 'VIM EX',
                 \  'ce' : 'EX',
                 \  'r'  : 'PROMPT',
                 \  'rm' : 'MORE',
                 \  'r?' : 'CONFIRM',
                 \  '!'  : 'SHELL',
                 \  't'  : 'TERMINAL'
                 \}

" Function: return current mode
" abort -> function will abort soon as error detected
function! ModeCurrent() abort
  return get(g:currentmode, mode())
endfunction

" }}}5

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

" Column number.
" preceded by a literal ': ', minimum 2
let &statusline .= ': %2c '

" }}}3

" Number of spaces that a <Tab> in the file counts for.
set tabstop=2

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
set textwidth=80

" Completion mode that is used for the character specified with 'wildchar'. It
" is a comma separated list of up to four parts. Each part specifies what to do
" for each consecutive use of 'wildchar'. The first part specifies the behavior
" for the first use of 'wildchar', The second part for the second use, etc.
set wildmode=longest:full

" }}}2

" key bindings {{{2

" Make "Y" key in normal mode behave more logical and analoguous to "C" and "D".
nnoremap Y y$

" }}}2

" }}}1

" The Silver Searcher | ag {{{1

if executable('ag')
  " Use ag over grep
  set grepprg =ag\ --nogroup\ --nocolor\ --hidden
endif

" }}}1

" Eclim {{{1

" TODO: check Eclim options

" Make eclim use YouCompleteMe as completion UI
let g:EclimCompletionMethod = 'omnifunc'

" Disable eclim validation
let g:EclimFileTypeValidate = 0

" }}}1

" ColorV | Rykka/colorv.vim {{{1

" Previewing color-text with same fg/bg colors.
let g:colorv_preview_area = 1

" }}}1

" CSV | chrisbra/csv.vim {{{1

" do not conceal delimiters
let g:csv_no_conceal = 1

" }}}1

" CtrlP | ctrlpvim/ctrlp.vim {{{1

" set up Silver Searcher (ag) use
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s --files-with-matches --nocolor --hidden --filename-pattern ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching  = 0
endif

" make CtrlP use the current working dir only
let g:ctrlp_working_path_mode = 0

" make CtrlP scan for dotfiles and dotdirs
let g:ctrlp_show_hidden = 1

" }}}1

" vim-markdown-composer | euclio/vim-markdown-composer {{{1

" Whether the server should automatically start when a markdown file is opened.
let g:markdown_composer_autostart = 0

" }}}1

" Tagbar | majutsushi/tagbar {{{1

" toggle Tagbar with typing <F8>
nnoremap <silent> <F8> :TagbarToggle<CR>

" If you set this option the Tagbar window will automatically close when you
" jump to a tag.
let g:tagbar_autoclose = 1

" If you set this option the cursor will move to the Tagbar window when it is
" opened.
let g:tagbar_autofocus = 1

" If this option is set the tags are sorted according to their name. If it is
" unset they are sorted according to their order in the source file.
let g:tagbar_sort = 0

" By default if the cursor is over a tag in the tagbar window, information
" about the tag is echoed out. Set this option to disable that behavior.
let g:tagbar_silent = 1

" Configure Tagbar to user ripper-tags with Ruby
if executable('ripper-tags')
  let g:tagbar_type_ruby = {
      \ 'kinds'      : ['m:modules',
                      \ 'c:classes',
                      \ 'C:constants',
                      \ 'F:singleton methods',
                      \ 'f:methods',
                      \ 'a:aliases'],
      \ 'kind2scope' : { 'c' : 'class',
                       \ 'm' : 'class' },
      \ 'scope2kind' : { 'class' : 'c' },
      \ 'ctagsbin'   : 'ripper-tags',
      \ 'ctagsargs'  : ['-f', '-']
      \ }
endif

" }}}1

" Vim Markdown | plasticboy/vim-markdown {{{1

" Fold like in python-mode (meaning, include headers as the first line of a
" fold.
let g:vim_markdown_folding_style_pythonic = 1

" Change the indent level of new list items to two spaces.
let g:vim_markdown_new_list_item_indent = 2

" Disable 'ge' motion override.
map <Plug> <Plug>Markdown_EditUrlUnderCursor

" }}}1

" NERD tree | scrooloose/nerdtree {{{1

" NERD tree shortcut
nnoremap <silent> <C-N> :NERDTreeToggle<CR>

" Exit Vim when the only open window is NERD tree.
augroup NERDTree
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

" }}}1

" Gundo | sjl/gundo.vim {{{1

" Gundo view shortcut
nnoremap <silent> <F5> :GundoToggle<CR>

" Set this to 0 to disable the help text in the Gundo graph window.
let g:gundo_help = 0

" Set this to 0 to disable automatically rendering preview diffs as you move
" through the undo tree (you can still render a specific diff with r).  This can
" be useful on large files and undo trees to speed up Gundo.
let g:gundo_auto_preview = 0

" }}}1

" vim-airline | vim-airline/vim-airline {{{1

" airline options {{{2

" By default, airline will use unicode symbols if your encoding matches utf-8.
" If you want the powerline symbols set this variable.
let g:airline_powerline_fonts = 1

" }}}2

" airline extension options {{{2

" airline-tagbar {{{3

" Disable Tagbar integration.
let g:airline#extensions#tagbar#enabled = 0

" }}}3

" airline-csv {{{3

" Show the name of columns. (Leads to wrong output, if no headers are
" available.)
let g:airline#extensions#csv#column_display = 'Name'

" }}}3

" airline-hunks {{{3

" Enable showing only non-zero hunks.
let g:airline#extensions#hunks#non_zero_only = 1

" }}}3

" }}}2

" }}}1

" vim-ruby | vim-ruby/vim-ruby {{{1

" Use the "do" indentation style, since it better conforms to the Ruby style
" guide.
let g:ruby_indent_block_style = 'do'

" Highlight operators. (Keeping it on, but seems to have no effect.)
let g:ruby_operators = 1

" Enable syntax based folding for Ruby files.
let g:ruby_fold = 1

" Specify what can be folded.
let g:ruby_foldable_groups = 'def class module # __END__ do'

" }}}1

" Asynchronous Lint Engine | w0rp/ale {{{1

" ALE general options {{{2

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

" }}}2

" ALE fixers {{{2

" A mapping from filetypes to List values for functions for fixing errors.
let g:ale_fixers = {
    \ 'sh' : ['shfmt']
    \ }

" }}}2

" ALE Ruby options {{{2

" ALE Ruby reek options {{{3

" Controls whether linter messages contain a link to an explanatory wiki page
" for the type of code smell. Defaults to off to improve readability.
let g:ale_ruby_reek_show_wiki_link = 1

" }}}3

" ALE Ruby rubocop options {{{3

" This variable can be changed to modify flags given to rubocop.
let g:ale_ruby_rubocop_options = '-DES'

" }}}3

" }}}2

" ALE sh options {{{2

let g:ale_sh_shfmt_options = '-s -i 2'

" }}}2

" }}}1
