" vim: foldmethod=marker foldlevel=0
" only read for GUI instances

" general Vim settings {{{1

" appearance settings {{{2

" Colorscheme settings {{{3

try
  colorscheme material
catch /^Vim(colorscheme):E185/
  echom '"material" colorscheme not found, using "morning" instead.'
  silent! colorscheme morning
endtry

" Vim options {{{2

" This is a list of fonts which will be used for the GUI version of Vim.
if has('win32')
  set guifont=FiraMono\ NF:h10
else
  set guifont=FiraMono\ Nerd\ Font\ Mono:h10
endif

" This option only has an effect in the GUI version of Vim.  It is a sequence of
" letters which describes what components and options of the GUI should be used.
set guioptions=cig
if !has('nvim')
  set guioptions+=!
endif

" nvim-qt specific options {{{3

if exists('g:GuiLoaded')
  " Use the TUI tabline
  GuiTabline 0

  " Use the TUI popup menu
  GuiPopupmenu 0
endif
