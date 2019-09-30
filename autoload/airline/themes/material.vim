" Vim: set foldmethod=marker:
" -----------------------------------------------------------------------------
" File:          material.vim
" Description:   The airline implementation of the configurable material theme
" Author:        Kai Moschcau <mail@kmoschcau.de>
" -----------------------------------------------------------------------------

" Define the basic palette
let g:airline#themes#material#palette = {}

function! g:airline#themes#material#refresh()
  let g:airline#themes#material#palette.inactive =
        \ g:airline#themes#generate_color_map(
        \   g:airline#themes#get_highlight('Airline1'),
        \   g:airline#themes#get_highlight('Airline2'),
        \   g:airline#themes#get_highlight('Airline3')
        \ )
  let g:airline#themes#material#palette.inactive_modified =
        \ copy(g:airline#themes#material#palette.inactive)
  let g:airline#themes#material#palette.inactive_modified.airline_c =
        \ g:airline#themes#get_highlight('AirlineModified')
  let g:airline#themes#material#palette.inactive_modified.airline_x =
        \ g:airline#themes#get_highlight('AirlineModified')

  let g:airline#themes#material#palette.normal =
        \ g:airline#themes#generate_color_map(
        \   g:airline#themes#get_highlight('AirlineNormal'),
        \   g:airline#themes#get_highlight('Airline2'),
        \   g:airline#themes#get_highlight('Airline3')
        \ )
  let g:airline#themes#material#palette.normal.airline_warning =
        \ g:airline#themes#get_highlight('AirlineWarning')
  let g:airline#themes#material#palette.normal.airline_error =
        \ g:airline#themes#get_highlight('AirlineError')
  let g:airline#themes#material#palette.normal_modified =
        \ copy(g:airline#themes#material#palette.normal)
  let g:airline#themes#material#palette.normal_modified.airline_c =
        \ g:airline#themes#get_highlight('AirlineModified')
  let g:airline#themes#material#palette.normal_modified.airline_x =
        \ g:airline#themes#get_highlight('AirlineModified')

  let g:airline#themes#material#palette.insert = {}
  let g:airline#themes#material#palette.insert.airline_a =
        \ g:airline#themes#get_highlight('AirlineInsert')
  let g:airline#themes#material#palette.insert.airline_z =
        \ g:airline#themes#get_highlight('AirlineInsert')
  let g:airline#themes#material#palette.insert.airline_warning =
        \ g:airline#themes#get_highlight('AirlineWarning')
  let g:airline#themes#material#palette.insert.airline_error =
        \ g:airline#themes#get_highlight('AirlineError')
  let g:airline#themes#material#palette.insert_modified =
        \ copy(g:airline#themes#material#palette.insert)
  let g:airline#themes#material#palette.insert_modified.airline_c =
        \ g:airline#themes#get_highlight('AirlineModified')
  let g:airline#themes#material#palette.insert_modified.airline_x =
        \ g:airline#themes#get_highlight('AirlineModified')

  let g:airline#themes#material#palette.replace = {}
  let g:airline#themes#material#palette.replace.airline_a =
        \ g:airline#themes#get_highlight('AirlineReplace')
  let g:airline#themes#material#palette.replace.airline_z =
        \ g:airline#themes#get_highlight('AirlineReplace')
  let g:airline#themes#material#palette.replace.airline_warning =
        \ g:airline#themes#get_highlight('AirlineWarning')
  let g:airline#themes#material#palette.replace.airline_error =
        \ g:airline#themes#get_highlight('AirlineError')
  let g:airline#themes#material#palette.replace_modified =
        \ copy(g:airline#themes#material#palette.replace)
  let g:airline#themes#material#palette.replace_modified.airline_c =
        \ g:airline#themes#get_highlight('AirlineModified')
  let g:airline#themes#material#palette.replace_modified.airline_x =
        \ g:airline#themes#get_highlight('AirlineModified')

  let g:airline#themes#material#palette.visual = {}
  let g:airline#themes#material#palette.visual.airline_a =
        \ g:airline#themes#get_highlight('AirlineVisual')
  let g:airline#themes#material#palette.visual.airline_z =
        \ g:airline#themes#get_highlight('AirlineVisual')
  let g:airline#themes#material#palette.visual.airline_warning =
        \ g:airline#themes#get_highlight('AirlineWarning')
  let g:airline#themes#material#palette.visual.airline_error =
        \ g:airline#themes#get_highlight('AirlineError')
  let g:airline#themes#material#palette.visual_modified =
        \ copy(g:airline#themes#material#palette.visual)
  let g:airline#themes#material#palette.visual_modified.airline_c =
        \ g:airline#themes#get_highlight('AirlineModified')
  let g:airline#themes#material#palette.visual_modified.airline_x =
        \ g:airline#themes#get_highlight('AirlineModified')

  call g:Material_replace_statusline_highlight()
endfunction

call g:airline#themes#material#refresh()
