" Vim: set foldmethod=marker:
" -----------------------------------------------------------------------------
" File:          material.vim
" Description:   The airline implementation of the configurable material theme
" Author:        Kai Moschcau <mail@kmoschcau.de>
" -----------------------------------------------------------------------------

let s:GenColorMap  = function('g:airline#themes#generate_color_map')
let s:GetHighlight = function('g:airline#themes#get_highlight')

let s:palette = {}
let s:inactive = s:GenColorMap(s:GetHighlight('Material_Airline1'),
                             \ s:GetHighlight('Material_VimLightFramingStrongFg'),
                             \ s:GetHighlight('Material_Airline3'))
let s:inactive.airline_term = s:inactive.airline_c
let s:inactive.airline_warning = s:GetHighlight('Material_VimWarningInverted')
let s:inactive.airline_error = s:GetHighlight('Material_VimErrorInverted')
let s:palette.inactive = s:inactive

let s:inactive_modified = {}
let s:inactive_modified.airline_c = s:GetHighlight('Material_AirlineModified')
let s:inactive_modified.airline_x = s:inactive_modified.airline_c
let s:palette.inactive_modified = s:inactive_modified

let s:normal = copy(s:inactive)
let s:normal.airline_a = s:GetHighlight('Material_VimStatusLine')
let s:normal.airline_z = s:normal.airline_a
let s:palette.normal = s:normal

let s:normal_modified = {}
let s:normal_modified.airline_a = s:normal.airline_a
let s:normal_modified.airline_z = s:normal.airline_a
let s:palette.normal_modified = s:normal_modified

let s:insert = copy(s:inactive)
let s:insert.airline_a = s:GetHighlight('Material_AirlineInsert')
let s:insert.airline_z = s:insert.airline_a
let s:palette.insert = s:insert

let s:insert_modified = {}
let s:insert_modified.airline_a = s:insert.airline_a
let s:insert_modified.airline_z = s:insert.airline_a
let s:palette.insert_modified = s:insert_modified

let s:replace = copy(s:inactive)
let s:replace.airline_a = s:GetHighlight('Material_AirlineReplace')
let s:replace.airline_z = s:replace.airline_a
let s:palette.replace = s:replace

let s:replace_modified = {}
let s:replace_modified.airline_a = s:replace.airline_a
let s:replace_modified.airline_z = s:replace.airline_a
let s:palette.replace_modified = s:replace_modified

let s:visual = copy(s:inactive)
let s:visual.airline_a = s:GetHighlight('Material_VimVisual')
let s:visual.airline_z = s:visual.airline_a
let s:palette.visual = s:visual

let s:visual_modified = {}
let s:visual_modified.airline_a = s:visual.airline_a
let s:visual_modified.airline_z = s:visual.airline_a
let s:palette.visual_modified = s:visual_modified

let g:airline#themes#material#palette = s:palette

call g:Material_replace_statusline_highlight()
