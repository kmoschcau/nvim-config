" Vim: set foldmethod=marker:

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
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
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
Plug 'vim-scripts/L9'
Plug 'vim-syntastic/syntastic'
" }}}2

" color schemes {{{2
Plug 'blueshirts/darcula'
" }}}2

" Initialize plugin system
call plug#end()
" }}}1

" Windows specific settings {{{1
if has('win32')
  " set the paths for the python executables (installed with chocolatey)
  let g:python_host_prog  = 'C:/Python27/python'
  let g:python3_host_prog = 'C:/Python36/python'
endif
" }}}1

" Vim options {{{1

" A comma separated list of screen columns that are highlighted with
" hl-ColorColumn. The screen column can be an absolute number, or a number
" preceded with '+' or '-', which is added to or subtracted from 'textwidth'.
set colorcolumn=+1

" Do include whitespace after a word with a 'cw' command. The desired behaviour
" would be to not do this, but it does not work because of
" 'chaoren/vim-wordmotion' anyway.
set cpoptions-=_

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
set expandtab

" Number of spaces that a <Tab> in the file counts for.
set tabstop=2

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=2

" Do smart autoindenting when starting a new line.
" (no effect, when 'indentexpr' is set)
set smartindent

" Write the swap file to disk after this many milliseconds.
" make vim update faster
set updatetime=250

" Print the line number in front of each line.
set number

" Switch on syntax highlighting.
syntax enable

" Disable wrapping of lines, that are too long for the buffer width.
set nowrap

" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width.
set textwidth=80

" Show (partial) command in the last line of the screen.
set showcmd

" Strings to use in 'list' mode and for the |:list| command.
set listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:n

" Display characters as defined in 'listchars'.
set list

" When there is a previous search pattern, highlight all its matches.
set hlsearch

" The value of this option influences when the last window will have a status
" line. (2: always)
set laststatus=2

" }}}1

" The Silver Searcher | ag {{{1
if executable('ag')
  " Use ag over grep
  set grepprg =ag\ --nogroup\ --nocolor
endif
" }}}1

" CtrlP | ctrlpvim/ctrlp.vim {{{1
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching  = 0
endif
" make CtrlP use the current working dir only
let g:ctrlp_working_path_mode = ''
" }}}1

"" appearance settings
" color scheme
colorscheme darcula
" set the font
set guifont =Ubuntu\ Mono\ derivative\ Powerline\ 12
" diff highlight settings
highlight DiffAdd    cterm=bold ctermfg=none ctermbg=22 gui=bold guifg=NONE guibg=DarkGreen
highlight DiffDelete cterm=bold ctermfg=none ctermbg=52 gui=bold guifg=Red  guibg=DarkRed
highlight DiffChange cterm=none ctermfg=none ctermbg=17 gui=none guifg=NONE guibg=DarkBlue
highlight DiffText   cterm=bold ctermfg=none ctermbg=19 gui=bold guifg=NONE guibg=SlateBlue



"" airline configuration
" airline color scheme
let g:airline_theme = 'powerlineish'
" populate dictionary
let g:airline_powerline_fonts = 1

"" nerdtree configuration
" nerdtree shortcut
map <C-n> :NERDTreeToggle<CR>
" exit Vim when the only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" csv plugin configuration
" display name if available
let g:airline#extensions#csv#column_display = 'Name'
" do not conceal delimiters
let g:csv_no_conceal = 1

"" syntastic settings
set statusline +=%#warningmsg#
set statusline +=%{SyntasticStatuslineFlag()}
set statusline +=%*
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq   = 0
let g:syntastic_auto_loc_list = 2
" java checkers
let g:syntastic_java_checkers = ['javac', 'checkstyle']
let g:syntastic_java_checkstyle_classpath = '/opt/checkstyle/checkstyle-8.1-all.jar'
let g:syntastic_java_checkstyle_conf_file = 'google_checks.xml'
" ruby checkers
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

"" tagbar config
" tagbar shortcut
nmap <F8> :TagbarToggle<CR>
" tagbar autofocus
let g:tagbar_autofocus = 1
" tagbar autoclose
let g:tagbar_autoclose = 1
" disable tagbar in airline
let g:airline#extensions#tagbar#enabled = 0
" " use 'ripper-tags' (if available) to generate ruby ctags with tagbar
if executable('ripper-tags')
  " Configure Tagbar to user ripper-tags with ruby
  let g:tagbar_type_ruby = {
        \ 'ctagstype' : 'ruby',
        \ 'kinds' : ['m:modules',
                   \ 'c:classes',
                   \ 'C:constants',
                   \ 'F:singleton methods',
                   \ 'f:methods',
                   \ 'a:aliases'],
        \ 'kind2scope' : {'m' : 'module',
                        \ 'c' : 'class'},
        \ 'sro' : '.',
        \ 'ctagsbin': 'ripper-tags',
        \ 'ctagsargs': ['-f', '-']
        \ }
endif

"" Eclim configuration
" make eclim use YouCompleteMe as completion UI
let g:EclimCompletionMethod = 'omnifunc'

"" vim-markdown configuration
" list indent spaces
let g:vim_markdown_new_list_item_indent = 2
" disable 'ge' motion override
map <Plug> <Plug>Markdown_EditUrlUnderCursor
