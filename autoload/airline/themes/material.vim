" Vim: set foldmethod=marker:
" -----------------------------------------------------------------------------
" File:          material.vim
" Description:   The airline implementation of the configurable material theme
" Author:        Kai Moschcau <mail@kmoschcau.de>
" -----------------------------------------------------------------------------

" Define the basic palette
let g:airline#themes#material#palette = {}

function! g:airline#themes#material#refresh()
  let l:GenColorMap  = funcref('g:airline#themes#generate_color_map')
  let l:GetHighlight = funcref('g:airline#themes#get_highlight')

  let l:palette = {}
  let l:inactive = GenColorMap(GetHighlight('Material_Airline1'),
                             \ GetHighlight('Material_VimLightFramingStrongFg'),
                             \ GetHighlight('Material_Airline3'))
  let l:inactive.airline_term = l:inactive.airline_c
  let l:inactive.airline_warning = GetHighlight('Material_VimWarningInverted')
  let l:inactive.airline_error = GetHighlight('Material_VimErrorInverted')
  let l:palette.inactive = l:inactive

  let l:inactive_modified = copy(l:palette.inactive)
  let l:inactive_modified.airline_c = GetHighlight('Material_AirlineModified')
  let l:inactive_modified.airline_x = l:inactive_modified.airline_c
  let l:palette.inactive_modified = l:inactive_modified

  let l:normal = copy(l:inactive)
  let l:normal.airline_a = GetHighlight('Material_VimStatusLine')
  let l:normal.airline_z = l:normal.airline_a
  let l:palette.normal = l:normal

  let l:normal_modified = copy(l:inactive_modified)
  let l:normal_modified.airline_a = l:normal.airline_a
  let l:normal_modified.airline_z = l:normal.airline_a
  let l:palette.normal_modified = l:normal_modified

  let l:insert = copy(l:inactive)
  let l:insert.airline_a = GetHighlight('Material_AirlineInsert')
  let l:insert.airline_z = l:insert.airline_a
  let l:palette.insert = l:insert

  let l:insert_modified = copy(l:inactive_modified)
  let l:insert_modified.airline_a = l:insert.airline_a
  let l:insert_modified.airline_z = l:insert.airline_a
  let l:palette.insert_modified = l:insert_modified

  let l:replace = copy(l:inactive)
  let l:replace.airline_a = GetHighlight('Material_AirlineReplace')
  let l:replace.airline_z = l:replace.airline_a
  let l:palette.replace = l:replace

  let l:replace_modified = copy(l:inactive_modified)
  let l:replace_modified.airline_a = l:replace.airline_a
  let l:replace_modified.airline_z = l:replace.airline_a
  let l:palette.replace_modified = l:replace_modified

  let l:visual = copy(l:inactive)
  let l:visual.airline_a = GetHighlight('Material_VimVisual')
  let l:visual.airline_z = l:visual.airline_a
  let l:palette.visual = l:visual

  let l:visual_modified = copy(l:inactive_modified)
  let l:visual_modified.airline_a = l:visual.airline_a
  let l:visual_modified.airline_z = l:visual.airline_a
  let l:palette.visual_modified = l:visual_modified

  let g:airline#themes#material#palette = l:palette

  call g:Material_replace_statusline_highlight()
endfunction

call g:airline#themes#material#refresh()
