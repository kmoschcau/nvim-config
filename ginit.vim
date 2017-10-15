" only read for GUI instances

" This is a list of fonts which will be used for the GUI version of Vim.
if has('win32')
  if exists('g:GuiLoaded')
    GuiFont Hack:h10
  endif
else
  set guifont=Hack
endif

" This option only has an effect in the GUI version of Vim.  It is a sequence of
" letters which describes what components and options of the GUI should be used.
" TODO: test with Ubuntu gui
set guioptions=cimgT