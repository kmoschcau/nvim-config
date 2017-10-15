" only read for GUI instances

" This is a list of fonts which will be used for the GUI version of Vim.
if has('win32')
  if exists('g:GuiLoaded')
    GuiFont('Hack:h10')
  endif
else
  set guifont=Hack
endif
