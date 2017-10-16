" Vim: set foldmethod=marker:

" Windows specific settings {{{1

if has('win32')
  " set the paths for the python executables (installed with chocolatey)
  let g:python_host_prog  = 'C:/Python27/python'
  let g:python3_host_prog = 'C:/Python36/python'
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

" Make sure you use single quotes

" general plugins {{{2

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'chaoren/vim-wordmotion'
Plug 'chrisbra/csv.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'infoslack/vim-docker'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'NLKNguyen/vim-maven-syntax'
Plug 'noprompt/vim-yardoc'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-syntastic/syntastic'

" }}}2

" color schemes {{{2

Plug 'blueshirts/darcula'

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

" Colorscheme settings {{{3

" darcula | blueshirts/darcula {{{4

colorscheme darcula

" }}}4

" }}}3

" Change the highligh group colors for diff highlight groups.
highlight DiffAdd    cterm=bold ctermfg=none ctermbg=22 gui=bold guifg=NONE guibg=DarkGreen
highlight DiffDelete cterm=bold ctermfg=none ctermbg=52 gui=bold guifg=Red  guibg=DarkRed
highlight DiffChange cterm=none ctermfg=none ctermbg=17 gui=none guifg=NONE guibg=DarkBlue
highlight DiffText   cterm=bold ctermfg=none ctermbg=19 gui=bold guifg=NONE guibg=SlateBlue

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
" for future reference
set fillchars=vert:│,fold:≍,diff:‡

" This is a sequence of letters which describes how automatic formatting is to
" be done. See fo-table.
set formatoptions=croqlj

" Configures the cursor style for each mode. Works in the GUI and some
" terminals.
" TODO: check tmux with this.
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

" When on, splitting a window will put the new window below the current one.
set splitbelow

" When on, splitting a window will put the new window right of the current one.
set splitright

" Number of spaces that a <Tab> in the file counts for.
set tabstop=2

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
set textwidth=80

" }}}2

" }}}1

" The Silver Searcher | ag {{{1

if executable('ag')
  " Use ag over grep
  set grepprg =ag\ --nogroup\ --nocolor
endif

" }}}1

" Eclim {{{1

" TODO: check Eclim options

" Make eclim use YouCompleteMe as completion UI
let g:EclimCompletionMethod = 'omnifunc'

" }}}1

" CSV | chrisbra/csv.vim {{{1

" do not conceal delimiters
let g:csv_no_conceal = 1

" }}}1

" CtrlP | ctrlpvim/ctrlp.vim {{{1

" set up Silver Searcher (ag) use
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s --files-with-matches --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching  = 0
endif

" make CtrlP use the current working dir only
let g:ctrlp_working_path_mode = 0

" make CtrlP scan for dotfiles and dotdirs
let g:ctrlp_show_hidden = 1

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
autocmd BufEnter *
  \   if (winnr("$") == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree())
  \ |   quit
  \ | endif

" If set to 1, the NERD tree window will close after opening a file with the
" |NERDTree-o|, |NERDTree-i|, |NERDTree-t| and |NERDTree-T| mappings.
let NERDTreeQuitOnOpen = 1

" This option tells Vim whether to display hidden files by default.
let NERDTreeShowHidden = 1

" }}}1

" vim-airline | vim-airline/vim-airline {{{1

" airline options {{{2

" Themes are automatically selected, based on the matching colorscheme. This can
" be overridden by defining a value.
" let g:airline_theme = 'powerlineish'

" By default, airline will use unicode symbols if your encoding matches utf-8.
" If you want the powerline symbols set this variable.
let g:airline_powerline_fonts = 1

" }}}2

" airline extension options {{{2

" airline-default {{{3

" Configure the layout to not use %(%) grouping items in the statusline. Try
" setting this to zero, if you notice bleeding color artifacts.
" TODO: test this with color bleeding
" let airline#extensions#default#section_use_groupitems = 1

" }}}3

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

" Highlight operators. (Currently has a bug, that causes heredocs to be rendered
" incorrectly.)
" let ruby_operators = 1

" Enable syntax based folding for Ruby files.
let ruby_fold = 1

" Specify what can be folded.
let ruby_foldable_groups = 'def class module # __END__'

" }}}1

" Syntastic | vim-syntastic/syntastic {{{1

" java checkers
" TODO: check general settings for this, maybe add guards
let g:syntastic_java_checkers = ['javac', 'checkstyle']
let g:syntastic_java_checkstyle_classpath = '/opt/checkstyle/checkstyle-8.1-all.jar'
let g:syntastic_java_checkstyle_conf_file = 'google_checks.xml'

" ruby checkers
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" }}}1
