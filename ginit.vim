" only read for GUI instances

" This is a list of fonts which will be used for the GUI version of Vim.
if has('win32')
  set guifont=Lucida\ Console:h10
else
  set guifont=Fira\ Code:h10
endif

" This option only has an effect in the GUI version of Vim.  It is a sequence of
" letters which describes what components and options of the GUI should be used.
set guioptions=!cig

colorscheme material
