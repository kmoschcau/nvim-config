" Vim: set foldmethod=marker:
" -----------------------------------------------------------------------------
" File:          material.vim
" Description:   A configurable material based theme
" Author:        Kai Moschcau <mail@kmoschcau.de>
" -----------------------------------------------------------------------------

" General setup {{{1
" Reset all highlight groups to the default.
highlight clear

" Set the name of the colortheme.
let g:colors_name = expand('<sfile>:t:r')

" Material color palette {{{2
let s:material =
      \ { 'red':         { '50':   { 'gui': '#ffebee', 'cterm': '255' },
                         \ '100':  { 'gui': '#ffcdd2', 'cterm': '224' },
                         \ '200':  { 'gui': '#ef9a9a', 'cterm': '210' },
                         \ '300':  { 'gui': '#e57373', 'cterm': '174' },
                         \ '400':  { 'gui': '#ef5350', 'cterm': '203' },
                         \ '500':  { 'gui': '#f44336', 'cterm': '203' },
                         \ '600':  { 'gui': '#e53935', 'cterm': '167' },
                         \ '700':  { 'gui': '#d32f2f', 'cterm': '160' },
                         \ '800':  { 'gui': '#c62828', 'cterm': '160' },
                         \ '900':  { 'gui': '#b71c1c', 'cterm': '124' },
                         \ 'A100': { 'gui': '#ff8a80', 'cterm': '210' },
                         \ 'A200': { 'gui': '#ff5252', 'cterm': '203' },
                         \ 'A400': { 'gui': '#ff1744', 'cterm': '197' },
                         \ 'A700': { 'gui': '#d50000', 'cterm': '160' } },
        \ 'pink':        { '50':   { 'gui': '#fce4ec', 'cterm': '255' },
                         \ '100':  { 'gui': '#f8bbd0', 'cterm': '218' },
                         \ '200':  { 'gui': '#f48fb1', 'cterm': '211' },
                         \ '300':  { 'gui': '#f06292', 'cterm': '204' },
                         \ '400':  { 'gui': '#ec407a', 'cterm': '204' },
                         \ '500':  { 'gui': '#e91e63', 'cterm': '161' },
                         \ '600':  { 'gui': '#d81b60', 'cterm': '161' },
                         \ '700':  { 'gui': '#c2185b', 'cterm': '125' },
                         \ '800':  { 'gui': '#ad1457', 'cterm': '125' },
                         \ '900':  { 'gui': '#880e4f', 'cterm':  '89' },
                         \ 'A100': { 'gui': '#ff80ab', 'cterm': '211' },
                         \ 'A200': { 'gui': '#ff4081', 'cterm': '204' },
                         \ 'A400': { 'gui': '#f50057', 'cterm': '197' },
                         \ 'A700': { 'gui': '#c51162', 'cterm': '161' } },
        \ 'purple':      { '50':   { 'gui': '#f3e5f5', 'cterm': '255' },
                         \ '100':  { 'gui': '#e1bee7', 'cterm': '182' },
                         \ '200':  { 'gui': '#ce93d8', 'cterm': '176' },
                         \ '300':  { 'gui': '#ba68c8', 'cterm': '134' },
                         \ '400':  { 'gui': '#ab47bc', 'cterm': '133' },
                         \ '500':  { 'gui': '#9c27b0', 'cterm': '127' },
                         \ '600':  { 'gui': '#8e24aa', 'cterm':  '91' },
                         \ '700':  { 'gui': '#7b1fa2', 'cterm':  '91' },
                         \ '800':  { 'gui': '#6a1b9a', 'cterm':  '54' },
                         \ '900':  { 'gui': '#4a148c', 'cterm':  '54' },
                         \ 'A100': { 'gui': '#ea80fc', 'cterm': '177' },
                         \ 'A200': { 'gui': '#e040fb', 'cterm': '171' },
                         \ 'A400': { 'gui': '#d500f9', 'cterm': '165' },
                         \ 'A700': { 'gui': '#aa00ff', 'cterm': '129' } },
        \ 'deep_purple': { '50':   { 'gui': '#ede7f6', 'cterm': '255' },
                         \ '100':  { 'gui': '#d1c4e9', 'cterm': '188' },
                         \ '200':  { 'gui': '#b39ddb', 'cterm': '146' },
                         \ '300':  { 'gui': '#9575cd', 'cterm': '104' },
                         \ '400':  { 'gui': '#7e57c2', 'cterm':  '97' },
                         \ '500':  { 'gui': '#673ab7', 'cterm':  '61' },
                         \ '600':  { 'gui': '#5e35b1', 'cterm':  '61' },
                         \ '700':  { 'gui': '#512da8', 'cterm':  '55' },
                         \ '800':  { 'gui': '#4527a0', 'cterm':  '55' },
                         \ '900':  { 'gui': '#311b92', 'cterm':  '54' },
                         \ 'A100': { 'gui': '#b388ff', 'cterm': '141' },
                         \ 'A200': { 'gui': '#7c4dff', 'cterm':  '99' },
                         \ 'A400': { 'gui': '#651fff', 'cterm':  '57' },
                         \ 'A700': { 'gui': '#6200ea', 'cterm':  '56' } },
        \ 'indigo':      { '50':   { 'gui': '#e8eaf6', 'cterm': '255' },
                         \ '100':  { 'gui': '#c5cae9', 'cterm': '252' },
                         \ '200':  { 'gui': '#9fa8da', 'cterm': '146' },
                         \ '300':  { 'gui': '#7986cb', 'cterm': '104' },
                         \ '400':  { 'gui': '#5c6bc0', 'cterm':  '61' },
                         \ '500':  { 'gui': '#3f51b5', 'cterm':  '61' },
                         \ '600':  { 'gui': '#3949ab', 'cterm':  '61' },
                         \ '700':  { 'gui': '#303f9f', 'cterm':  '61' },
                         \ '800':  { 'gui': '#283593', 'cterm':  '24' },
                         \ '900':  { 'gui': '#1a237e', 'cterm':  '18' },
                         \ 'A100': { 'gui': '#8c9eff', 'cterm': '111' },
                         \ 'A200': { 'gui': '#536dfe', 'cterm':  '63' },
                         \ 'A400': { 'gui': '#3d5afe', 'cterm':  '63' },
                         \ 'A700': { 'gui': '#304ffe', 'cterm':  '63' } },
        \ 'blue':        { '50':   { 'gui': '#e3f2fd', 'cterm': '195' },
                         \ '100':  { 'gui': '#bbdefb', 'cterm': '153' },
                         \ '200':  { 'gui': '#90caf9', 'cterm': '117' },
                         \ '300':  { 'gui': '#64b5f6', 'cterm':  '75' },
                         \ '400':  { 'gui': '#42a5f5', 'cterm':  '75' },
                         \ '500':  { 'gui': '#2196f3', 'cterm':  '33' },
                         \ '600':  { 'gui': '#1e88e5', 'cterm':  '32' },
                         \ '700':  { 'gui': '#1976d2', 'cterm':  '32' },
                         \ '800':  { 'gui': '#1565c0', 'cterm':  '25' },
                         \ '900':  { 'gui': '#0d47a1', 'cterm':  '25' },
                         \ 'A100': { 'gui': '#82b1ff', 'cterm': '111' },
                         \ 'A200': { 'gui': '#448aff', 'cterm':  '69' },
                         \ 'A400': { 'gui': '#2979ff', 'cterm':  '33' },
                         \ 'A700': { 'gui': '#2962ff', 'cterm':  '27' } },
        \ 'light_blue':  { '50':   { 'gui': '#e1f5fe', 'cterm': '195' },
                         \ '100':  { 'gui': '#b3e5fc', 'cterm': '153' },
                         \ '200':  { 'gui': '#81d4fa', 'cterm': '117' },
                         \ '300':  { 'gui': '#4fc3f7', 'cterm':  '81' },
                         \ '400':  { 'gui': '#29b6f6', 'cterm':  '39' },
                         \ '500':  { 'gui': '#03a9f4', 'cterm':  '39' },
                         \ '600':  { 'gui': '#039be5', 'cterm':  '38' },
                         \ '700':  { 'gui': '#0288d1', 'cterm':  '32' },
                         \ '800':  { 'gui': '#0277bd', 'cterm':  '31' },
                         \ '900':  { 'gui': '#01579b', 'cterm':  '25' },
                         \ 'A100': { 'gui': '#80d8ff', 'cterm': '117' },
                         \ 'A200': { 'gui': '#40c4ff', 'cterm':  '81' },
                         \ 'A400': { 'gui': '#00b0ff', 'cterm':  '39' },
                         \ 'A700': { 'gui': '#0091ea', 'cterm':  '32' } },
        \ 'cyan':        { '50':   { 'gui': '#e0f7fa', 'cterm': '195' },
                         \ '100':  { 'gui': '#b2ebf2', 'cterm': '159' },
                         \ '200':  { 'gui': '#80deea', 'cterm': '116' },
                         \ '300':  { 'gui': '#4dd0e1', 'cterm':  '80' },
                         \ '400':  { 'gui': '#26c6da', 'cterm':  '44' },
                         \ '500':  { 'gui': '#00bcd4', 'cterm':  '38' },
                         \ '600':  { 'gui': '#00acc1', 'cterm':  '37' },
                         \ '700':  { 'gui': '#0097a7', 'cterm':  '31' },
                         \ '800':  { 'gui': '#00838f', 'cterm':  '30' },
                         \ '900':  { 'gui': '#006064', 'cterm':  '23' },
                         \ 'A100': { 'gui': '#84ffff', 'cterm': '123' },
                         \ 'A200': { 'gui': '#18ffff', 'cterm':  '51' },
                         \ 'A400': { 'gui': '#00e5ff', 'cterm':  '45' },
                         \ 'A700': { 'gui': '#00b8d4', 'cterm':  '38' } },
        \ 'teal':        { '50':   { 'gui': '#e0f2f1', 'cterm': '255' },
                         \ '100':  { 'gui': '#b2dfdb', 'cterm': '152' },
                         \ '200':  { 'gui': '#80cbc4', 'cterm': '116' },
                         \ '300':  { 'gui': '#4db6ac', 'cterm':  '73' },
                         \ '400':  { 'gui': '#26a69a', 'cterm':  '36' },
                         \ '500':  { 'gui': '#009688', 'cterm':  '30' },
                         \ '600':  { 'gui': '#00897b', 'cterm':  '30' },
                         \ '700':  { 'gui': '#00796b', 'cterm':  '29' },
                         \ '800':  { 'gui': '#00695c', 'cterm':  '23' },
                         \ '900':  { 'gui': '#004d40', 'cterm':  '23' },
                         \ 'A100': { 'gui': '#a7ffeb', 'cterm': '159' },
                         \ 'A200': { 'gui': '#64ffda', 'cterm':  '86' },
                         \ 'A400': { 'gui': '#1de9b6', 'cterm':  '43' },
                         \ 'A700': { 'gui': '#00bfa5', 'cterm':  '37' } },
        \ 'green':       { '50':   { 'gui': '#e8f5e9', 'cterm': '255' },
                         \ '100':  { 'gui': '#c8e6c9', 'cterm': '252' },
                         \ '200':  { 'gui': '#a5d6a7', 'cterm': '151' },
                         \ '300':  { 'gui': '#81c784', 'cterm': '114' },
                         \ '400':  { 'gui': '#66bb6a', 'cterm':  '71' },
                         \ '500':  { 'gui': '#4caf50', 'cterm':  '71' },
                         \ '600':  { 'gui': '#43a047', 'cterm':  '71' },
                         \ '700':  { 'gui': '#388e3c', 'cterm':  '65' },
                         \ '800':  { 'gui': '#2e7d32', 'cterm': '239' },
                         \ '900':  { 'gui': '#1b5e20', 'cterm':  '22' },
                         \ 'A100': { 'gui': '#b9f6ca', 'cterm': '158' },
                         \ 'A200': { 'gui': '#69f0ae', 'cterm':  '85' },
                         \ 'A400': { 'gui': '#00e676', 'cterm':  '42' },
                         \ 'A700': { 'gui': '#00c853', 'cterm':  '41' } },
        \ 'light_green': { '50':   { 'gui': '#f1f8e9', 'cterm': '255' },
                         \ '100':  { 'gui': '#dcedc8', 'cterm': '194' },
                         \ '200':  { 'gui': '#c5e1a5', 'cterm': '187' },
                         \ '300':  { 'gui': '#aed581', 'cterm': '150' },
                         \ '400':  { 'gui': '#9ccc65', 'cterm': '149' },
                         \ '500':  { 'gui': '#8bc34a', 'cterm': '113' },
                         \ '600':  { 'gui': '#7cb342', 'cterm': '107' },
                         \ '700':  { 'gui': '#689f38', 'cterm':  '71' },
                         \ '800':  { 'gui': '#558b2f', 'cterm':  '64' },
                         \ '900':  { 'gui': '#33691e', 'cterm':  '58' },
                         \ 'A100': { 'gui': '#ccff90', 'cterm': '192' },
                         \ 'A200': { 'gui': '#b2ff59', 'cterm': '155' },
                         \ 'A400': { 'gui': '#76ff03', 'cterm': '118' },
                         \ 'A700': { 'gui': '#64dd17', 'cterm':  '76' } },
        \ 'lime':        { '50':   { 'gui': '#f9fbe7', 'cterm': '230' },
                         \ '100':  { 'gui': '#f0f4c3', 'cterm': '230' },
                         \ '200':  { 'gui': '#e6ee9c', 'cterm': '193' },
                         \ '300':  { 'gui': '#dce775', 'cterm': '186' },
                         \ '400':  { 'gui': '#d4e157', 'cterm': '185' },
                         \ '500':  { 'gui': '#cddc39', 'cterm': '185' },
                         \ '600':  { 'gui': '#c0ca33', 'cterm': '149' },
                         \ '700':  { 'gui': '#afb42b', 'cterm': '142' },
                         \ '800':  { 'gui': '#9e9d24', 'cterm': '142' },
                         \ '900':  { 'gui': '#827717', 'cterm': '100' },
                         \ 'A100': { 'gui': '#f4ff81', 'cterm': '228' },
                         \ 'A200': { 'gui': '#eeff41', 'cterm': '227' },
                         \ 'A400': { 'gui': '#c6ff00', 'cterm': '190' },
                         \ 'A700': { 'gui': '#aeea00', 'cterm': '148' } },
        \ 'yellow':      { '50':   { 'gui': '#fffde7', 'cterm': '230' },
                         \ '100':  { 'gui': '#fff9c4', 'cterm': '230' },
                         \ '200':  { 'gui': '#fff59d', 'cterm': '229' },
                         \ '300':  { 'gui': '#fff176', 'cterm': '228' },
                         \ '400':  { 'gui': '#ffee58', 'cterm': '227' },
                         \ '500':  { 'gui': '#ffeb3b', 'cterm': '227' },
                         \ '600':  { 'gui': '#fdd835', 'cterm': '221' },
                         \ '700':  { 'gui': '#fbc02d', 'cterm': '214' },
                         \ '800':  { 'gui': '#f9a825', 'cterm': '214' },
                         \ '900':  { 'gui': '#f57f17', 'cterm': '208' },
                         \ 'A100': { 'gui': '#ffff8d', 'cterm': '228' },
                         \ 'A200': { 'gui': '#ffff00', 'cterm': '226' },
                         \ 'A400': { 'gui': '#ffea00', 'cterm': '220' },
                         \ 'A700': { 'gui': '#ffd600', 'cterm': '220' } },
        \ 'amber':       { '50':   { 'gui': '#fff8e1', 'cterm': '230' },
                         \ '100':  { 'gui': '#ffecb3', 'cterm': '229' },
                         \ '200':  { 'gui': '#ffe082', 'cterm': '222' },
                         \ '300':  { 'gui': '#ffd54f', 'cterm': '221' },
                         \ '400':  { 'gui': '#ffca28', 'cterm': '220' },
                         \ '500':  { 'gui': '#ffc107', 'cterm': '214' },
                         \ '600':  { 'gui': '#ffb300', 'cterm': '214' },
                         \ '700':  { 'gui': '#ffa000', 'cterm': '214' },
                         \ '800':  { 'gui': '#ff8f00', 'cterm': '208' },
                         \ '900':  { 'gui': '#ff6f00', 'cterm': '202' },
                         \ 'A100': { 'gui': '#ffe57f', 'cterm': '222' },
                         \ 'A200': { 'gui': '#ffd740', 'cterm': '221' },
                         \ 'A400': { 'gui': '#ffc400', 'cterm': '220' },
                         \ 'A700': { 'gui': '#ffab00', 'cterm': '214' } },
        \ 'orange':      { '50':   { 'gui': '#fff3e0', 'cterm': '230' },
                         \ '100':  { 'gui': '#ffe0b2', 'cterm': '223' },
                         \ '200':  { 'gui': '#ffcc80', 'cterm': '222' },
                         \ '300':  { 'gui': '#ffb74d', 'cterm': '215' },
                         \ '400':  { 'gui': '#ffa726', 'cterm': '214' },
                         \ '500':  { 'gui': '#ff9800', 'cterm': '208' },
                         \ '600':  { 'gui': '#fb8c00', 'cterm': '208' },
                         \ '700':  { 'gui': '#f57c00', 'cterm': '208' },
                         \ '800':  { 'gui': '#ef6c00', 'cterm': '202' },
                         \ '900':  { 'gui': '#e65100', 'cterm': '166' },
                         \ 'A100': { 'gui': '#ffd180', 'cterm': '222' },
                         \ 'A200': { 'gui': '#ffab40', 'cterm': '215' },
                         \ 'A400': { 'gui': '#ff9100', 'cterm': '208' },
                         \ 'A700': { 'gui': '#ff6d00', 'cterm': '202' } },
        \ 'deep_orange': { '50':   { 'gui': '#fbe9e7', 'cterm': '255' },
                         \ '100':  { 'gui': '#ffccbc', 'cterm': '223' },
                         \ '200':  { 'gui': '#ffab91', 'cterm': '216' },
                         \ '300':  { 'gui': '#ff8a65', 'cterm': '209' },
                         \ '400':  { 'gui': '#ff7043', 'cterm': '203' },
                         \ '500':  { 'gui': '#ff5722', 'cterm': '202' },
                         \ '600':  { 'gui': '#f4511e', 'cterm': '202' },
                         \ '700':  { 'gui': '#e64a19', 'cterm': '166' },
                         \ '800':  { 'gui': '#d84315', 'cterm': '166' },
                         \ '900':  { 'gui': '#bf360c', 'cterm': '130' },
                         \ 'A100': { 'gui': '#ff9e80', 'cterm': '216' },
                         \ 'A200': { 'gui': '#ff6e40', 'cterm': '203' },
                         \ 'A400': { 'gui': '#ff3d00', 'cterm': '202' },
                         \ 'A700': { 'gui': '#dd2c00', 'cterm': '160' } },
        \ 'brown':       { '50':   { 'gui': '#efebe9', 'cterm': '255' },
                         \ '100':  { 'gui': '#d7ccc8', 'cterm': '252' },
                         \ '200':  { 'gui': '#bcaaa4', 'cterm': '145' },
                         \ '300':  { 'gui': '#a1887f', 'cterm': '138' },
                         \ '400':  { 'gui': '#8d6e63', 'cterm':  '95' },
                         \ '500':  { 'gui': '#795548', 'cterm':  '95' },
                         \ '600':  { 'gui': '#6d4c41', 'cterm': '240' },
                         \ '700':  { 'gui': '#5d4037', 'cterm': '238' },
                         \ '800':  { 'gui': '#4e342e', 'cterm': '237' },
                         \ '900':  { 'gui': '#3e2723', 'cterm': '236' } },
        \ 'grey':        { '50':   { 'gui': '#fafafa', 'cterm': '231' },
                         \ '100':  { 'gui': '#f5f5f5', 'cterm': '255' },
                         \ '200':  { 'gui': '#eeeeee', 'cterm': '255' },
                         \ '300':  { 'gui': '#e0e0e0', 'cterm': '254' },
                         \ '400':  { 'gui': '#bdbdbd', 'cterm': '250' },
                         \ '500':  { 'gui': '#9e9e9e', 'cterm': '247' },
                         \ '600':  { 'gui': '#757575', 'cterm': '243' },
                         \ '700':  { 'gui': '#616161', 'cterm': '241' },
                         \ '800':  { 'gui': '#424242', 'cterm': '238' },
                         \ '900':  { 'gui': '#212121', 'cterm': '235' } },
        \ 'blue_grey':   { '50':   { 'gui': '#eceff1', 'cterm': '255' },
                         \ '100':  { 'gui': '#cfd8dc', 'cterm': '188' },
                         \ '200':  { 'gui': '#b0bec5', 'cterm': '250' },
                         \ '300':  { 'gui': '#90a4ae', 'cterm': '109' },
                         \ '400':  { 'gui': '#78909c', 'cterm': '103' },
                         \ '500':  { 'gui': '#607d8b', 'cterm':  '66' },
                         \ '600':  { 'gui': '#546e7a', 'cterm':  '60' },
                         \ '700':  { 'gui': '#455a64', 'cterm': '240' },
                         \ '800':  { 'gui': '#37474f', 'cterm': '238' },
                         \ '900':  { 'gui': '#263238', 'cterm': '236' } },
        \ 'transparent': { 'gui': 'NONE', 'cterm': 'NONE' } }


" Default hue selection {{{2

" A dict of user configured hues
let s:user_hues = get(g:, 'material_hues', {})

" Hue used for most of the editor background and framing, should be subtle.
let s:hue_neutral = get(s:user_hues, 'neutral', 'grey')

" Hue used as the primary accent for currently interacted with elements in
" normal mode
let s:hue_primary = get(s:user_hues, 'primary', 'cyan')

" Hue used for insert mode
let s:hue_insert = get(s:user_hues, 'insert', 'blue')

" Hue used for replace mode
let s:hue_replace = get(s:user_hues, 'replace', 'amber')

" Diff hues {{{3
" Hue used for added diff
let s:diff_added_hue = get(g:, 'material_diff_added_hue', 'green')

" Hue used for changed diff
let s:diff_changed_hue = get(g:, 'material_diff_changed_hue', 'amber')

" Hue used for deleted diff
let s:diff_deleted_hue = get(g:, 'material_diff_deleted_hue', 'red')

" Hue used for text diff
let s:diff_text_hue = get(g:, 'material_diff_text_hue', 'orange')

" value list  {{{2
let s:normal_values = [ '50', '100', '200', '300', '400', '500', '600',
                    \  '700', '800', '900']
let s:accent_values = ['A100', 'A200', 'A400', 'A700']

" Shared colors {{{2

let s:c_transparent = s:material['transparent']

" Functions {{{2

" Set the highlight group passed as group_name to the values specified in
" color_dictionary.
function! s:highlight(group_name, color_dictionary)
  let l:attr = get(a:color_dictionary, 'attr', 'NONE')
  let l:fg = get(a:color_dictionary, 'fg', {})
  let l:bg = get(a:color_dictionary, 'bg', {})
  let l:sp = get(a:color_dictionary, 'sp', {})
  exec 'highlight ' . a:group_name
     \ . ' cterm=' . l:attr
     \ . ' ctermfg=' . get(l:fg, 'cterm', s:c_transparent.cterm)
     \ . ' ctermbg=' . get(l:bg, 'cterm', s:c_transparent.cterm)
     \ . ' gui=' . l:attr
     \ . ' guifg=' . get(l:fg, 'gui', s:c_transparent.gui)
     \ . ' guibg=' . get(l:bg, 'gui', s:c_transparent.gui)
     \ . ' guisp=' . get(l:sp, 'gui', s:c_transparent.gui)
endfunction

" Get the value number string for the passed index, dependent on the
" 'background'.
function! s:value(index)
  let l:index = max([min([a:index, 10]), 1])
  if &background ==? 'light'
    let l:value_index = l:index - 1
  else
    let l:value_index = 0 - l:index
  endif
  return s:normal_values[l:value_index]
endfunction

" Get the accent value number string for the passed index, dependent on the
" 'background'.
function! s:accent_value(index)
  let l:index = max([min([a:index, 4]), 1])
  if &background ==? 'light'
    let l:value_index = l:index - 1
  else
    let l:value_index = 0 - l:index
  endif
  return s:accent_values[l:value_index]
endfunction

" Get a color value by the passed color name and the passed index, dependent on
" the 'background'.
function! s:color_dict(color_name, color_index, ...)
  if a:0 > 0
    let l:value = s:accent_value(a:color_index)
    if 'brown|grey|blue_grey' =~# a:color_name
      let l:value = l:value[1:3]
    endif
    return s:material[a:color_name][l:value]
  else
    return s:material[a:color_name][s:value(a:color_index)]
  endif
endfunction

" Copy the passed color dictionary without the "attr" key
function! s:copy_without_attr(color_dictionary)
  let l:dict_copy = copy(a:color_dictionary)
  unlet l:dict_copy.attr
  return l:dict_copy
endfunction

" This replaces the default statusline highlight with the strong framing
" highlight. This is meant to be used to remove the differing, one character
" highlight on the right side of the statusline for windows on the bottom when
" airline is in use.
function! g:Material_replace_statusline_highlight()
  call s:highlight('StatusLine', s:h_vim_strong_framing_with_fg)
endfunction

" Shared highlight definitions {{{2
" Basics {{{3

let s:h_vim_normal =
      \ { 'fg':   s:color_dict(s:hue_neutral, 8),
      \   'bg':   s:color_dict(s:hue_neutral, 1) }
let s:h_vim_normal_light =
      \ { 'fg':   s:color_dict(s:hue_neutral, 5) }
let s:h_vim_special_key =
      \ { 'attr': 'italic',
      \   'fg':   s:color_dict(s:hue_neutral, 8),
      \   'bg':   s:color_dict(s:hue_neutral, 3) }
let s:h_vim_conceal =
      \ { 'fg':   s:color_dict(s:hue_neutral, 8) }

" Popup menu and floating windows {{{3
let s:h_vim_popup =
      \ { 'fg':   s:color_dict(s:hue_neutral, 8),
      \   'bg':   s:color_dict(s:hue_neutral, 2) }
let s:h_vim_popup_selected =
      \ { 'bg':   s:color_dict(s:hue_primary, 2) }
let s:h_vim_popup_scrollbar =
      \ { 'bg':   s:color_dict(s:hue_neutral, 5) }
let s:h_vim_popup_thumb =
      \ { 'bg':   s:color_dict(s:hue_neutral, 10) }

" Framing {{{3
let s:h_vim_lighter_framing =
      \ { 'bg':   s:color_dict(s:hue_neutral, 2) }
let s:h_vim_light_framing_subtle_fg =
      \ { 'fg':   s:color_dict(s:hue_neutral, 7),
      \   'bg':   s:color_dict(s:hue_neutral, 5) }
let s:h_vim_light_framing_strong_fg =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:hue_neutral, 5) }
let s:h_vim_strong_framing_without_fg =
      \ { 'bg':   s:color_dict(s:hue_neutral, 8) }
let s:h_vim_strong_framing_with_fg =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1, 'accent'),
      \   'bg':   s:color_dict(s:hue_neutral, 8) }
let s:h_vim_status_line =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:hue_primary, 4, 'accent') }
let s:h_vim_status_line_nc =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:hue_neutral, 8) }

" Cursor related {{{3
let s:h_vim_visual =
      \ { 'bg':   s:color_dict(s:hue_primary, 2) }
let s:h_vim_wild_menu =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:hue_primary, 3) }
let s:h_vim_cursorlines =
      \ { 'bg':   s:color_dict(s:hue_primary, 2) }
let s:h_vim_cursorlines_num =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict(s:hue_neutral, 6),
      \   'bg':   s:color_dict(s:hue_primary, 2) }
let s:h_vim_cursor =
      \ { 'bg':   s:color_dict(s:hue_primary, 6) }
let s:h_vim_cursor_insert =
      \ { 'bg':   s:color_dict(s:hue_insert, 7) }
let s:h_vim_cursor_replace =
      \ { 'bg':   s:color_dict(s:hue_replace, 7) }
let s:h_vim_cursor_unfocused =
      \ { 'bg':   s:color_dict(s:hue_primary, 3) }

" Diff related {{{3
let s:h_vim_diff_add =
      \ { 'fg':   s:color_dict(s:diff_added_hue, 6) }
let s:h_vim_diff_delete =
      \ { 'fg':   s:color_dict(s:diff_deleted_hue, 6) }
let s:h_vim_diff_line_add =
      \ { 'bg':   s:color_dict(s:diff_added_hue, 2) }
let s:h_vim_diff_line_change =
      \ { 'bg':   s:color_dict(s:diff_changed_hue, 2) }
let s:h_vim_diff_line_change_delete =
      \ { 'bg':   s:color_dict(s:diff_changed_hue, 3) }
let s:h_vim_diff_line_delete =
      \ { 'bg':   s:color_dict(s:diff_deleted_hue, 2) }
let s:h_vim_diff_line_text =
      \ { 'attr': 'bold',
      \   'bg':   s:color_dict(s:diff_text_hue, 2) }
let s:h_vim_diff_sign_add =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:diff_added_hue, 6) }
let s:h_vim_diff_sign_change =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:diff_changed_hue, 6) }
let s:h_vim_diff_sign_change_delete =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:diff_changed_hue, 7) }
let s:h_vim_diff_sign_delete =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:diff_deleted_hue, 6) }

" Messages {{{3
let s:h_vim_title =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('pink', 5) }
let s:h_vim_mode_msg =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict(s:hue_neutral, 8) }
let s:h_vim_more_msg =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('green', 8) }
let s:h_vim_error_inverted =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict('red', 6) }
let s:h_vim_error_underline =
      \ { 'attr': 'underline',
      \   'sp':   s:color_dict('red', 6) }
let s:h_vim_style_error_inverted =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict('red', 3) }
let s:h_vim_style_error_underline =
      \ { 'attr': 'undercurl',
      \   'sp':   s:color_dict('red', 3) }
let s:h_vim_warning_inverted =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict('orange', 6) }
let s:h_vim_warning_underline =
      \ { 'attr': 'underline',
      \   'sp':   s:color_dict('orange', 6) }
let s:h_vim_style_warning_inverted =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict('orange', 3) }
let s:h_vim_style_warning_underline =
      \ { 'attr': 'undercurl',
      \   'sp':   s:color_dict('orange', 3) }
let s:h_vim_info_inverted =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict('light_blue', 6) }
let s:h_vim_info_underline =
      \ { 'attr': 'underline',
      \   'sp':   s:color_dict('light_blue', 6) }

" Spelling {{{3
let s:h_vim_spell_bad =
      \ { 'attr': 'undercurl',
      \   'sp':   s:color_dict('red', 6) }
let s:h_vim_spell_cap =
      \ { 'attr': 'undercurl',
      \   'sp':   s:color_dict('indigo', 6) }
let s:h_vim_spell_rare =
      \ { 'attr': 'undercurl',
      \   'sp':   s:color_dict('pink', 4) }
let s:h_vim_spell_local =
      \ { 'attr': 'undercurl',
      \   'sp':   s:color_dict('teal', 6) }

" Misc {{{3
let s:h_vim_directory =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('blue', 5) }
let s:h_vim_folded =
      \ { 'fg':   s:color_dict(s:hue_neutral, 6),
      \   'bg':   s:color_dict(s:hue_neutral, 3) }
let s:h_vim_search =
      \ { 'bg':   s:color_dict('yellow', 6) }
let s:h_vim_inc_search =
      \ { 'attr': 'bold',
      \   'bg':   s:color_dict('orange', 6) }
let s:h_vim_match_paren =
      \ { 'bg':   s:color_dict('teal', 3) }

" Testing {{{3
let s:h_debug_test =
      \ { 'attr': 'bold,italic,undercurl',
      \   'fg':   s:color_dict('blue', 4),
      \   'bg':   s:color_dict('green', 9),
      \   'sp':   s:color_dict('red', 3) }

" Syntax {{{3
" Built-in {{{4

" Comment and linked groups
let s:h_syn_comment =
      \ { 'fg':   s:color_dict(s:hue_neutral, 6) }

" Constant and linked groups
let s:h_syn_constant =
      \ { 'fg':   s:color_dict('blue_grey', 7),
      \   'bg':   s:color_dict('blue_grey', 1) }
let s:h_syn_string =
      \ { 'fg':   s:color_dict('green', 7),
      \   'bg':   s:color_dict('green', 1) }
let s:h_syn_character =
      \ { 'fg':   s:color_dict('light_green', 7),
      \   'bg':   s:color_dict('light_green', 1) }
let s:h_syn_number =
      \ { 'fg':   s:color_dict('blue', 7),
      \   'bg':   s:color_dict('blue', 1) }
let s:h_syn_boolean =
      \ { 'fg':   s:color_dict('orange', 7),
      \   'bg':   s:color_dict('orange', 1) }
let s:h_syn_float =
      \ { 'fg':   s:color_dict('light_blue', 7),
      \   'bg':   s:color_dict('light_blue', 1) }

" Statement and linked groups
let s:h_syn_statement =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('orange', 7) }
let s:h_syn_operator =
      \ { 'fg':   s:color_dict('orange', 7) }

" PreProc and linked groups
let s:h_syn_pre_proc =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('teal', 5) }

" Type and linked groups
let s:h_syn_storage_class =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('yellow', 8) }

" Special and linked groups
let s:h_syn_special =
      \ { 'fg':   s:color_dict('red', 7) }

" Underlined and linked groups
let s:h_syn_underlined =
      \ { 'attr': 'underline',
      \   'fg':   s:color_dict('blue', 7) }

" Todo and linked groups
let s:h_syn_todo =
      \ { 'attr': 'bold' }

" Custom {{{4
" General {{{5

" Member variables
let s:h_syn_constant_name =
      \ { 'fg':   s:color_dict('indigo', 6) }
let s:h_syn_field_name =
      \ { 'fg':   s:color_dict('blue', 6) }

" Other variables
let s:h_syn_local_name =
      \ { 'attr': 'italic',
      \   'fg':   s:color_dict('orange', 4) }
let s:h_syn_parameter_name =
      \ { 'attr': 'italic',
      \   'fg':   s:color_dict('orange', 6) }

" Functions and methods
let s:h_syn_function_keyword =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('teal', 6) }
let s:h_syn_function_name = s:copy_without_attr(s:h_syn_function_keyword)
let s:h_syn_accessor_name =
      \ { 'fg':   s:color_dict('cyan', 6) }

" Types (primitive types and similar)
let s:h_syn_type_keyword =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('lime', 6) }
let s:h_syn_type_name = s:copy_without_attr(s:h_syn_type_keyword)

" Structures (smaller than classes, but not quite primitive types)
let s:h_syn_structure_keyword =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('light_green', 6) }
let s:h_syn_structure_name = s:copy_without_attr(s:h_syn_structure_keyword)

" Typedefs (Classes and equally large/extensible things)
let s:h_syn_typedef_keyword =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('green', 6) }
let s:h_syn_typedef_name = s:copy_without_attr(s:h_syn_typedef_keyword)

" Namespaces (or anything that groups together definitions)
let s:h_syn_namespace_keyword =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('brown', 4) }
let s:h_syn_namespace_name = s:copy_without_attr(s:h_syn_namespace_keyword)

" Generic context background
let s:h_syn_generic =
      \ { 'bg':   s:color_dict('purple', 1) }

" Interfaces (or anything that is just a declaration, but not implementation)
let s:h_syn_interface_keyword =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('purple', 4) }
let s:h_syn_interface_name = s:copy_without_attr(s:h_syn_interface_keyword)

" File type specific {{{5

let s:h_syn_vimscript_comment_string =
      \ { 'fg':   s:color_dict('green', 5) }

" Plugins {{{3
" OmniSharp | OmniSharp/omnisharp-vim {{{4

let s:h_omnisharp_extension_method_name =
      \ { 'fg':   s:color_dict('teal', 4) }

let s:h_omnisharp_operator_overloaded =
      \ { 'fg':   s:color_dict('orange', 7),
      \   'bg':   s:color_dict('orange', 2) }

let s:h_omnisharp_type_parameter_name =
      \ { 'fg':   s:h_syn_structure_name.fg,
      \   'bg':   s:h_syn_generic.bg }

let s:h_omnisharp_verbatim_string_literal =
      \ { 'fg':   s:color_dict('green', 7),
      \   'bg':   s:color_dict('green', 2) }

let s:h_omnisharp_xml_doc_comment_attribute_name =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('green', 3) }

let s:h_omnisharp_xml_doc_comment_attribute_quotes =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('green', 3) }

let s:h_omnisharp_xml_doc_comment_attribute_value =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict('green', 3) }

let s:h_omnisharp_xml_doc_comment_delimiter =
      \ { 'fg':   s:color_dict('teal', 3) }

let s:h_omnisharp_xml_doc_comment_name =
      \ { 'fg':   s:color_dict('orange', 3) }

let s:h_omnisharp_xml_doc_comment_text =
      \ { 'fg':   s:color_dict(s:hue_neutral, 6) }

" vim-airline | vim-airline/vim-airline {{{4

let s:h_airline_1 =
      \ { 'fg':   s:color_dict(s:hue_neutral, 6),
      \   'bg':   s:color_dict(s:hue_neutral, 2) }
let s:h_airline_3 =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:hue_neutral, 8) }

let s:h_airline_insert =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:hue_insert, 7) }
let s:h_airline_replace =
      \ { 'attr': 'bold',
      \   'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict(s:hue_replace, 7) }

let s:h_airline_modified =
      \ { 'fg':   s:color_dict(s:hue_neutral, 1),
      \   'bg':   s:color_dict('purple', 8) }

" Editor colors {{{1
" Non-editor window highlights {{{2
" Framing {{{3
call s:highlight('MsgSeparator', s:h_vim_strong_framing_without_fg)
call s:highlight('TabLineFill', s:h_vim_strong_framing_without_fg)
call s:highlight('VertSplit', s:h_vim_strong_framing_without_fg)

call s:highlight('FoldColumn', s:h_vim_light_framing_subtle_fg)
call s:highlight('SignColumn', s:h_vim_light_framing_subtle_fg)
call s:highlight('LineNr', s:h_vim_light_framing_subtle_fg)

call s:highlight('ColorColumn', s:h_vim_lighter_framing)

call s:highlight('CursorLineNr', s:h_vim_cursorlines_num)

call s:highlight('TabLine', s:h_vim_light_framing_strong_fg)
call s:highlight('TabLineSel', s:h_vim_normal)
call s:highlight('Title', s:h_vim_title)

call s:highlight('StatusLine', s:h_vim_status_line)
call s:highlight('StatusLineNC', s:h_vim_status_line_nc)
call s:highlight('StatusLineTerm', s:h_vim_status_line)
call s:highlight('StatusLineTermNC', s:h_vim_status_line_nc)

call s:highlight('WildMenu', s:h_vim_wild_menu)

" Popup menu and floating windows {{{3
call s:highlight('Pmenu', s:h_vim_popup)
call s:highlight('PmenuSel', s:h_vim_popup_selected)
call s:highlight('PmenuSbar', s:h_vim_popup_scrollbar)
call s:highlight('PmenuThumb', s:h_vim_popup_thumb)
call s:highlight('NormalFloat', s:h_vim_popup)

" Editor window highlights {{{2
" Normal text {{{3
call s:highlight('NonText', s:h_vim_normal_light)
call s:highlight('Normal', s:h_vim_normal)
call s:highlight('NormalNC', s:h_vim_normal)
call s:highlight('MsgArea', s:h_vim_normal)

" Cursor {{{3
call s:highlight('Cursor', s:h_vim_cursor)
call s:highlight('CursorInsert', s:h_vim_cursor_insert)
call s:highlight('CursorReplace', s:h_vim_cursor_replace)
call s:highlight('CursorIM', s:h_debug_test) " I don't really use this
call s:highlight('CursorColumn', s:h_vim_cursorlines)
call s:highlight('CursorLine', s:h_vim_cursorlines)
call s:highlight('IncSearch', s:h_vim_inc_search)
call s:highlight('MatchParen', s:h_vim_match_paren)
call s:highlight('QuickFixLine', s:h_vim_visual)
call s:highlight('Search', s:h_vim_search)
call s:highlight('Substitute', s:h_vim_search)
call s:highlight('TermCursor', s:h_vim_cursor)
call s:highlight('TermCursorNC', s:h_vim_cursor_unfocused)
call s:highlight('Visual', s:h_vim_visual)
call s:highlight('VisualNOS', s:h_debug_test) " doesn't seem to work

" Special character visualization {{{3
call s:highlight('Conceal', s:h_vim_conceal)
call s:highlight('EndOfBuffer', s:h_vim_normal_light)
call s:highlight('SpecialKey', s:h_vim_special_key)
call s:highlight('Whitespace', s:h_vim_normal_light)

" Diff {{{3
call s:highlight('DiffAdd', s:h_vim_diff_line_add)
call s:highlight('DiffChange', s:h_vim_diff_line_change)
call s:highlight('DiffDelete', s:h_vim_diff_line_delete)
call s:highlight('DiffText', s:h_vim_diff_line_text)

" Spelling {{{3
call s:highlight('SpellBad', s:h_vim_spell_bad)
call s:highlight('SpellCap', s:h_vim_spell_cap)
call s:highlight('SpellLocal', s:h_vim_spell_local)
call s:highlight('SpellRare', s:h_vim_spell_rare)

" Special items {{{2
call s:highlight('Directory', s:h_vim_directory)
call s:highlight('Folded', s:h_vim_folded)

" Messages {{{2
call s:highlight('ErrorMsg', s:h_vim_error_inverted)
call s:highlight('ModeMsg', s:h_vim_mode_msg)
call s:highlight('MoreMsg', s:h_vim_more_msg)
call s:highlight('Question', s:h_vim_more_msg)
call s:highlight('WarningMsg', s:h_vim_warning_inverted)

" Syntax groups {{{2
call s:highlight('Comment', s:h_syn_comment)

call s:highlight('Constant', s:h_syn_constant)
call s:highlight('String', s:h_syn_string)
call s:highlight('Character', s:h_syn_character)
call s:highlight('Number', s:h_syn_number)
call s:highlight('Boolean', s:h_syn_boolean)
call s:highlight('Float', s:h_syn_float)

call s:highlight('Identifier', s:h_syn_structure_name)
call s:highlight('Function', s:h_syn_function_name)

call s:highlight('Statement', s:h_syn_statement)
call s:highlight('Operator', s:h_syn_operator)

call s:highlight('PreProc', s:h_syn_pre_proc)

call s:highlight('Type', s:h_syn_type_keyword)
call s:highlight('StorageClass', s:h_syn_storage_class)
call s:highlight('Structure', s:h_syn_structure_keyword)
call s:highlight('Typedef', s:h_syn_typedef_keyword)

call s:highlight('Special', s:h_syn_special)

call s:highlight('Underlined', s:h_syn_underlined)

call s:highlight('Error', s:h_vim_error_inverted)

call s:highlight('Todo', s:h_syn_todo)

" custom variables {{{1
" terminal color variables {{{2
let g:terminal_color_0  = s:color_dict('grey', 9).gui
let g:terminal_color_1  = s:color_dict('red', 6).gui
let g:terminal_color_2  = s:color_dict('light_green', 6).gui
let g:terminal_color_3  = s:color_dict('amber', 8).gui
let g:terminal_color_4  = s:color_dict('blue', 6).gui
let g:terminal_color_5  = s:color_dict('purple', 6).gui
let g:terminal_color_6  = s:color_dict('cyan', 6).gui
let g:terminal_color_7  = s:color_dict('grey', 6).gui
let g:terminal_color_8  = s:color_dict('grey', 5).gui
let g:terminal_color_9  = s:color_dict('red', 4).gui
let g:terminal_color_10 = s:color_dict('light_green', 4).gui
let g:terminal_color_11 = s:color_dict('amber', 6).gui
let g:terminal_color_12 = s:color_dict('blue', 4).gui
let g:terminal_color_13 = s:color_dict('purple', 4).gui
let g:terminal_color_14 = s:color_dict('cyan', 4).gui
let g:terminal_color_15 = s:color_dict('grey', 4).gui

" custom highlight groups {{{1
" debugging highlight groups {{{2

call s:highlight('Test', s:h_debug_test)

" File type highlight groups {{{2
" cs (C#) {{{3

call s:highlight('csBraces', s:h_syn_special)
call s:highlight('csClass', s:h_syn_typedef_keyword)
call s:highlight('csClassType', s:h_syn_typedef_name)
call s:highlight('csEndColon', s:h_syn_special)
call s:highlight('csGeneric', s:h_syn_generic)
call s:highlight('csNewType', s:h_syn_typedef_name)
call s:highlight('csParens', s:h_syn_special)
call s:highlight('csStorage', s:h_syn_namespace_keyword)

" gitcommit {{{3

call s:highlight('gitCommitBlank', s:h_vim_style_error_underline)
call s:highlight('gitcommitOverflow', s:h_vim_style_warning_underline)

" vim (VimScript|VimL) {{{3

call s:highlight('vimCommentString', s:h_syn_vimscript_comment_string)
call s:highlight('vimFunction', s:h_syn_function_name)
call s:highlight('vimUserFunc', s:h_syn_function_name)

" highlight groups for plugins {{{2
" Asynchronous Lint Engine | w0rp/ale {{{3

call s:highlight('ALEError', s:h_vim_error_underline)
call s:highlight('ALEErrorSign', s:h_vim_error_inverted)
call s:highlight('ALEVirtualTextError', s:h_vim_error_inverted)

call s:highlight('ALEInfo', s:h_vim_info_underline)
call s:highlight('ALEInfoSign', s:h_vim_info_inverted)
call s:highlight('ALEVirtualTextInfo', s:h_vim_info_inverted)

call s:highlight('ALEStyleError', s:h_vim_style_error_underline)
call s:highlight('ALEStyleErrorSign', s:h_vim_style_error_inverted)
call s:highlight('ALEVirtualTextStyleError', s:h_vim_style_error_inverted)

call s:highlight('ALEStyleWarning', s:h_vim_style_warning_underline)
call s:highlight('ALEStyleWarningSign', s:h_vim_style_warning_inverted)
call s:highlight('ALEVirtualTextStyleWarning', s:h_vim_style_warning_inverted)

call s:highlight('ALEWarning', s:h_vim_warning_underline)
call s:highlight('ALEWarningSign', s:h_vim_warning_inverted)
call s:highlight('ALEVirtualTextWarning', s:h_vim_warning_inverted)

" coc.nvim | neoclide/coc.nvim {{{3

call s:highlight('CocCodeLens', s:h_syn_comment)

" vim-git | tpope/vim-git {{{3

call s:highlight('diffAdded', s:h_vim_diff_add)
call s:highlight('diffRemoved', s:h_vim_diff_delete)

" Signify | mhinz/vim-signify {{{3

call s:highlight('SignifySignAdd', s:h_vim_diff_sign_add)
call s:highlight('SignifySignChange', s:h_vim_diff_sign_change)
call s:highlight('SignifySignChangeDelete', s:h_vim_diff_sign_change_delete)
call s:highlight('SignifySignDelete', s:h_vim_diff_sign_delete)
call s:highlight('SignifySignDeleteFirstLine', s:h_vim_diff_sign_delete)

call s:highlight('SignifyLineAdd', s:h_vim_diff_line_add)
call s:highlight('SignifyLineChange', s:h_vim_diff_line_change)
call s:highlight('SignifyLineChangeDelete', s:h_vim_diff_line_change_delete)
call s:highlight('SignifyLineDelete', s:h_vim_diff_line_delete)
call s:highlight('SignifyLineDeleteFirstLine', s:h_vim_diff_line_delete)

" OmniSharp | OmniSharp/omnisharp-vim {{{3

call s:highlight('OmniSharpClassName', s:h_syn_typedef_name)
call s:highlight('OmniSharpConstantName', s:h_syn_constant_name)
call s:highlight('OmniSharpEnumMemberName', s:h_syn_structure_name)
call s:highlight('OmniSharpEnumName', s:h_syn_structure_keyword)
call s:highlight('OmniSharpExtensionMethodName', s:h_omnisharp_extension_method_name)
call s:highlight('OmniSharpFieldName', s:h_syn_field_name)
call s:highlight('OmniSharpInterfaceName', s:h_syn_interface_name)
call s:highlight('OmniSharpLocalName', s:h_syn_local_name)
call s:highlight('OmniSharpNamespaceName', s:h_syn_namespace_name)
call s:highlight('OmniSharpOperatorOverloaded', s:h_omnisharp_operator_overloaded)
call s:highlight('OmniSharpParameterName', s:h_syn_parameter_name)
call s:highlight('OmniSharpPropertyName', s:h_syn_accessor_name)
call s:highlight('OmniSharpStructName', s:h_syn_structure_name)
call s:highlight('OmniSharpTypeParameterName', s:h_omnisharp_type_parameter_name)
call s:highlight('OmniSharpVerbatimStringLiteral', s:h_omnisharp_verbatim_string_literal)

call s:highlight('OmniSharpXmlDocCommentAttributeName', s:h_omnisharp_xml_doc_comment_attribute_name)
call s:highlight('OmniSharpXmlDocCommentAttributeQuotes', s:h_omnisharp_xml_doc_comment_attribute_quotes)
call s:highlight('OmniSharpXmlDocCommentAttributeValue', s:h_omnisharp_xml_doc_comment_attribute_value)
call s:highlight('OmniSharpXmlDocCommentDelimiter', s:h_omnisharp_xml_doc_comment_delimiter)
call s:highlight('OmniSharpXmlDocCommentName', s:h_omnisharp_xml_doc_comment_name)
call s:highlight('OmniSharpXmlDocCommentText', s:h_omnisharp_xml_doc_comment_text)

let g:OmniSharp_highlight_groups = {
      \ 'Comment':                            'Comment',
      \ 'ExcludedCode':                       'Test',
      \ 'Identifier':                         'Identifier',
      \ 'Keyword':                            'Keyword',
      \ 'ControlKeyword':                     'Conditional',
      \ 'NumericLiteral':                     'Number',
      \ 'Operator':                           'Operator',
      \ 'OperatorOverloaded':                 'OmniSharpOperatorOverloaded',
      \ 'PreprocessorKeyword':                'PreProc',
      \ 'StringLiteral':                      'String',
      \ 'WhiteSpace':                         'Test',
      \ 'Text':                               'Test',
      \ 'StaticSymbol':                       'Test',
      \ 'PreprocessorText':                   'Normal',
      \ 'Punctuation':                        'Delimiter',
      \ 'VerbatimStringLiteral':              'OmniSharpVerbatimStringLiteral',
      \ 'StringEscapeCharacter':              'SpecialChar',
      \ 'ClassName':                          'OmniSharpClassName',
      \ 'DelegateName':                       'Test',
      \ 'EnumName':                           'OmniSharpEnumName',
      \ 'InterfaceName':                      'OmniSharpInterfaceName',
      \ 'ModuleName':                         'Test',
      \ 'StructName':                         'OmniSharpStructName',
      \ 'TypeParameterName':                  'OmniSharpTypeParameterName',
      \ 'FieldName':                          'OmniSharpFieldName',
      \ 'EnumMemberName':                     'OmniSharpEnumMemberName',
      \ 'ConstantName':                       'OmniSharpConstantName',
      \ 'LocalName':                          'OmniSharpLocalName',
      \ 'ParameterName':                      'OmniSharpParameterName',
      \ 'MethodName':                         'Function',
      \ 'ExtensionMethodName':                'OmniSharpExtensionMethodName',
      \ 'PropertyName':                       'OmniSharpPropertyName',
      \ 'EventName':                          'Test',
      \ 'NamespaceName':                      'OmniSharpNamespaceName',
      \ 'LabelName':                          'Test',
      \ 'XmlDocCommentAttributeName':         'OmniSharpXmlDocCommentAttributeName',
      \ 'XmlDocCommentAttributeQuotes':       'OmniSharpXmlDocCommentAttributeQuotes',
      \ 'XmlDocCommentAttributeValue':        'OmniSharpXmlDocCommentAttributeValue',
      \ 'XmlDocCommentCDataSection':          'OmniSharpXmlDocCommentText',
      \ 'XmlDocCommentComment':               'Comment',
      \ 'XmlDocCommentDelimiter':             'OmniSharpXmlDocCommentDelimiter',
      \ 'XmlDocCommentEntityReference':       'Test',
      \ 'XmlDocCommentName':                  'OmniSharpXmlDocCommentName',
      \ 'XmlDocCommentProcessingInstruction': 'Test',
      \ 'XmlDocCommentText':                  'OmniSharpXmlDocCommentText',
      \ 'XmlLiteralAttributeName':            'Test',
      \ 'XmlLiteralAttributeQuotes':          'Test',
      \ 'XmlLiteralAttributeValue':           'Test',
      \ 'XmlLiteralCDataSection':             'Test',
      \ 'XmlLiteralComment':                  'Test',
      \ 'XmlLiteralDelimiter':                'Test',
      \ 'XmlLiteralEmbeddedExpression':       'Test',
      \ 'XmlLiteralEntityReference':          'Test',
      \ 'XmlLiteralName':                     'Test',
      \ 'XmlLiteralProcessingInstruction':    'Test',
      \ 'XmlLiteralText':                     'Test',
      \ 'RegexComment':                       'Test',
      \ 'RegexCharacterClass':                'Test',
      \ 'RegexAnchor':                        'Test',
      \ 'RegexQuantifier':                    'Test',
      \ 'RegexGrouping':                      'Test',
      \ 'RegexAlternation':                   'Test',
      \ 'RegexText':                          'Test',
      \ 'RegexSelfEscapedCharacter':          'Test',
      \ 'RegexOtherEscape':                   'Test',
      \}

" vim-airline | vim-airline/vim-airline {{{3

call s:highlight('Airline1', s:h_airline_1)
call s:highlight('Airline2', s:h_vim_light_framing_strong_fg)
call s:highlight('Airline3', s:h_airline_3)

call s:highlight('AirlineNormal', s:h_vim_status_line)
call s:highlight('AirlineInsert', s:h_airline_insert)
call s:highlight('AirlineReplace', s:h_airline_replace)
call s:highlight('AirlineVisual', s:h_vim_visual)

call s:highlight('AirlineWarning', s:h_vim_warning_inverted)
call s:highlight('AirlineError', s:h_vim_error_inverted)

call s:highlight('AirlineModified', s:h_airline_modified)
