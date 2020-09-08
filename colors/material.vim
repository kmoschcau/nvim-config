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
let s:hue_diff_added = get(s:user_hues, 'diff_added', 'green')

" Hue used for changed diff
let s:hue_diff_changed = get(s:user_hues, 'diff_changed', 'amber')

" Hue used for deleted diff
let s:hue_diff_deleted = get(s:user_hues, 'diff_deleted', 'red')

" Hue used for text diff
let s:hue_diff_text = get(s:user_hues, 'diff_text', 'orange')

" value list  {{{2

let s:normal_values = [ '50', '100', '200', '300', '400', '500', '600',
                    \  '700', '800', '900']
let s:accent_values = ['A100', 'A200', 'A400', 'A700']

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

" This replaces the default statusline highlight with the strong framing
" highlight. This is meant to be used to remove the differing, one character
" highlight on the right side of the statusline for windows on the bottom when
" airline is in use.
function! g:Material_replace_statusline_highlight()
  highlight! link StatusLine Material_VimStrongFramingWithFg
endfunction

" Shared colors {{{2

let s:c_transparent             = s:material['transparent']

let s:c_neutral_lightest        = s:color_dict(s:hue_neutral, 1)
let s:c_neutral_midpoint        = s:color_dict(s:hue_neutral, 5)
let s:c_neutral_midpoint_strong = s:color_dict(s:hue_neutral, 6)
let s:c_neutral_strong          = s:color_dict(s:hue_neutral, 8)

let s:c_interact_light          = s:color_dict(s:hue_primary, 2)

let s:c_error_light             = s:color_dict('red', 3)
let s:c_error_strong            = s:color_dict('red', 6)
let s:c_warning_light           = s:color_dict('orange', 3)
let s:c_warning_strong          = s:color_dict('orange', 6)
let s:c_info_strong             = s:color_dict('light_blue', 6)

let s:c_syntax_meta_light       = s:color_dict('purple', 1)
let s:c_syntax_meta_strong      = s:color_dict('purple', 4)
let s:c_syntax_function         = s:color_dict('teal', 6)
let s:c_syntax_typedef          = s:color_dict('green', 6)
let s:c_syntax_structure        = s:color_dict('light_green', 6)
let s:c_syntax_type             = s:color_dict('lime', 6)
let s:c_syntax_namespace        = s:color_dict('brown', 4)

" Highlight definitions {{{2
" Basics {{{3

" This is somewhat of a hack and not like I intended it. But just linking the
" Normal group to anything instead of defining it on its own will cause the
" current window to have a transparent background for some reason.
highlight! link Material_VimNormal Normal
call s:highlight('Normal',
                 \ { 'fg':   s:c_neutral_strong,
                 \   'bg':   s:c_neutral_lightest })
call s:highlight('Material_VimNormalLight',
                 \ { 'fg':   s:c_neutral_midpoint,
                 \   'bg':   s:c_neutral_lightest })
call s:highlight('Material_VimSpecialKey',
                 \ { 'attr': 'italic',
                 \   'fg':   s:c_neutral_strong,
                 \   'bg':   s:color_dict(s:hue_neutral, 3) })
call s:highlight('Material_VimConceal',
                 \ { 'fg':   s:c_neutral_strong })

" Popup menu and floating windows {{{3

call s:highlight('Material_VimPopup',
                 \ { 'fg':   s:c_neutral_strong,
                 \   'bg':   s:color_dict(s:hue_neutral, 2) })
call s:highlight('Material_VimPopupSelected',
                 \ { 'bg':   s:c_interact_light })
call s:highlight('Material_VimPopupScrollbar',
                 \ { 'bg':   s:c_neutral_midpoint })
call s:highlight('Material_VimPopupThumb',
                 \ { 'bg':   s:color_dict(s:hue_neutral, 10) })

" Framing {{{3

call s:highlight('Material_VimLighterFraming',
                 \ { 'bg':   s:color_dict(s:hue_neutral, 2) })
call s:highlight('Material_VimLightFramingSubtleFg',
                 \ { 'fg':   s:color_dict(s:hue_neutral, 7),
                 \   'bg':   s:c_neutral_midpoint })
call s:highlight('Material_VimLightFramingStrongFg',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:c_neutral_midpoint })
call s:highlight('Material_VimStrongFramingWithoutFg',
                 \ { 'bg':   s:c_neutral_strong })
call s:highlight('Material_VimStrongFramingWithFg',
                 \ { 'fg':   s:color_dict(s:hue_neutral, 1, 'accent'),
                 \   'bg':   s:c_neutral_strong })
call s:highlight('Material_VimStatusLine',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict(s:hue_primary, 4, 'accent') })
call s:highlight('Material_VimStatusLineNC',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:c_neutral_strong })

" Cursor related {{{3

call s:highlight('Material_VimVisual',
                 \ { 'bg':   s:c_interact_light })
call s:highlight('Material_VimWildMenu',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict(s:hue_primary, 3) })
call s:highlight('Material_VimCursorLines',
                 \ { 'bg':   s:c_interact_light })
call s:highlight('Material_VimCursorLinesNum',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_neutral_midpoint_strong,
                 \   'bg':   s:c_interact_light })
call s:highlight('Material_VimCursor',
                 \ { 'bg':   s:color_dict(s:hue_primary, 6) })
call s:highlight('Material_VimCursorInsert',
                 \ { 'bg':   s:color_dict(s:hue_insert, 7) })
call s:highlight('Material_VimCursorReplace',
                 \ { 'bg':   s:color_dict(s:hue_replace, 7) })
call s:highlight('Material_VimCursorUnfocused',
                 \ { 'bg':   s:color_dict(s:hue_primary, 3) })

" Diff related {{{3

call s:highlight('Material_VimDiffAdd',
                 \ { 'fg':   s:color_dict(s:hue_diff_added, 6) })
call s:highlight('Material_VimDiffDelete',
                 \ { 'fg':   s:color_dict(s:hue_diff_deleted, 6) })
call s:highlight('Material_VimDiffLineAdd',
                 \ { 'bg':   s:color_dict(s:hue_diff_added, 2) })
call s:highlight('Material_VimDiffLineChange',
                 \ { 'bg':   s:color_dict(s:hue_diff_changed, 2) })
call s:highlight('Material_VimDiffLineChangeDelete',
                 \ { 'bg':   s:color_dict(s:hue_diff_changed, 3) })
call s:highlight('Material_VimDiffLineDelete',
                 \ { 'bg':   s:color_dict(s:hue_diff_deleted, 2) })
call s:highlight('Material_VimDiffLineText',
                 \ { 'attr': 'bold',
                 \   'bg':   s:color_dict(s:hue_diff_text, 2) })
call s:highlight('Material_VimDiffSignAdd',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict(s:hue_diff_added, 6) })
call s:highlight('Material_VimDiffSignChange',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict(s:hue_diff_changed, 6) })
call s:highlight('Material_VimDiffSignChangeDelete',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict(s:hue_diff_changed, 7) })
call s:highlight('Material_VimDiffSignDelete',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict(s:hue_diff_deleted, 6) })

" Messages {{{3

call s:highlight('Material_VimTitle',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('pink', 5) })
call s:highlight('Material_VimModeMsg',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_neutral_strong })
call s:highlight('Material_VimMoreMsg',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('green', 8) })
call s:highlight('Material_VimErrorInverted',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:c_error_strong })
call s:highlight('Material_VimErrorUnderline',
                 \ { 'attr': 'underline',
                 \   'sp':   s:c_error_strong })
call s:highlight('Material_VimStyleErrorInverted',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:c_error_light })
call s:highlight('Material_VimStyleErrorUnderline',
                 \ { 'attr': 'undercurl',
                 \   'sp':   s:c_error_light })
call s:highlight('Material_VimWarningInverted',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:c_warning_strong })
call s:highlight('Material_VimWarningUnderline',
                 \ { 'attr': 'underline',
                 \   'sp':   s:c_warning_strong })
call s:highlight('Material_VimStyleWarningInverted',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:c_warning_light })
call s:highlight('Material_VimStyleWarningUnderline',
                 \ { 'attr': 'undercurl',
                 \   'sp':   s:c_warning_light })
call s:highlight('Material_VimInfoInverted',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:c_info_strong })
call s:highlight('Material_VimInfoUnderline',
                 \ { 'attr': 'underline',
                 \   'sp':   s:c_info_strong })

" Spelling {{{3

call s:highlight('Material_VimSpellBad',
                 \ { 'attr': 'undercurl',
                 \   'sp':   s:c_error_strong })
call s:highlight('Material_VimSpellCap',
                 \ { 'attr': 'undercurl',
                 \   'sp':   s:color_dict('indigo', 6) })
call s:highlight('Material_VimSpellLocal',
                 \ { 'attr': 'undercurl',
                 \   'sp':   s:color_dict('teal', 6) })
call s:highlight('Material_VimSpellRare',
                 \ { 'attr': 'undercurl',
                 \   'sp':   s:color_dict('pink', 4) })

" Misc {{{3

call s:highlight('Material_VimDirectory',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('blue', 5) })
call s:highlight('Material_VimFolded',
                 \ { 'fg':   s:c_neutral_midpoint_strong,
                 \   'bg':   s:color_dict(s:hue_neutral, 3) })
call s:highlight('Material_VimSearch',
                 \ { 'bg':   s:color_dict('yellow', 6) })
call s:highlight('Material_VimIncSearch',
                 \ { 'attr': 'bold',
                 \   'bg':   s:color_dict('orange', 6) })
call s:highlight('Material_VimMatchParen',
                 \ { 'bg':   s:color_dict('teal', 3) })

" Testing {{{3

call s:highlight('Material_DebugTest',
                 \ { 'attr': 'bold,italic,undercurl',
                 \   'fg':   s:color_dict('blue', 4),
                 \   'bg':   s:color_dict('green', 9),
                 \   'sp':   s:color_dict('red', 3) })

" Syntax {{{3
" Built-in {{{4

" Comment and linked groups
call s:highlight('Material_SynComment',
                 \ { 'fg':   s:c_neutral_midpoint_strong })

" Constant and linked groups
call s:highlight('Material_SynConstant',
                 \ { 'fg':   s:color_dict('blue_grey', 7),
                 \   'bg':   s:color_dict('blue_grey', 1) })
call s:highlight('Material_SynString',
                 \ { 'fg':   s:color_dict('green', 7),
                 \   'bg':   s:color_dict('green', 1) })
call s:highlight('Material_SynCharacter',
                 \ { 'fg':   s:color_dict('light_green', 7),
                 \   'bg':   s:color_dict('light_green', 1) })
call s:highlight('Material_SynNumber',
                 \ { 'fg':   s:color_dict('blue', 7),
                 \   'bg':   s:color_dict('blue', 1) })
call s:highlight('Material_SynBoolean',
                 \ { 'fg':   s:color_dict('orange', 7),
                 \   'bg':   s:color_dict('orange', 1) })
call s:highlight('Material_SynFloat',
                 \ { 'fg':   s:color_dict('light_blue', 7),
                 \   'bg':   s:color_dict('light_blue', 1) })

" Statement and linked groups
call s:highlight('Material_SynStatement',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('orange', 7) })
call s:highlight('Material_SynOperator',
                 \ { 'fg':   s:color_dict('orange', 7) })

" PreProc and linked groups
call s:highlight('Material_SynPreProc',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('teal', 5) })

" Type and linked groups
call s:highlight('Material_SynStorageClass',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('yellow', 8) })

" Special and linked groups
call s:highlight('Material_SynSpecial',
                 \ { 'fg':   s:color_dict('red', 7) })

" Underlined and linked groups
call s:highlight('Material_SynUnderlined',
                 \ { 'attr': 'underline',
                 \   'fg':   s:color_dict('blue', 7) })

" Todo and linked groups
call s:highlight('Material_SynTodo',
                 \ { 'attr': 'bold' })

" Custom {{{4
" General {{{5

" Member variables
call s:highlight('Material_SynConstantName',
                 \ { 'fg':   s:color_dict('indigo', 6) })
call s:highlight('Material_SynFieldName',
                 \ { 'fg':   s:color_dict('blue', 6) })

" Other variables
call s:highlight('Material_SynLocalName',
                 \ { 'attr': 'italic',
                 \   'fg':   s:color_dict('orange', 4) })
call s:highlight('Material_SynParameterName',
                 \ { 'attr': 'italic',
                 \   'fg':   s:color_dict('orange', 6) })

" Functions and methods
call s:highlight('Material_SynFunctionKeyword',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_syntax_function })
call s:highlight('Material_SynFunctionName',
                 \ { 'fg':   s:c_syntax_function })
call s:highlight('Material_SynAccessorName',
                 \ { 'fg':   s:color_dict('cyan', 6) })

" Types (primitive types and similar)
call s:highlight('Material_SynTypeKeyword',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_syntax_type })
call s:highlight('Material_SynTypeName',
                 \ { 'fg':   s:c_syntax_type })

" Structures (smaller than classes, but not quite primitive types)
call s:highlight('Material_SynStructureKeyword',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_syntax_structure })
call s:highlight('Material_SynStructureName',
                 \ { 'fg':   s:c_syntax_structure })

" Typedefs (Classes and equally large/extensible things)
call s:highlight('Material_SynTypedefKeyword',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_syntax_typedef })
call s:highlight('Material_SynTypedefName',
                 \ { 'fg':   s:c_syntax_typedef })

" Namespaces (or anything that groups together definitions)
call s:highlight('Material_SynNamespaceKeyword',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_syntax_namespace })
call s:highlight('Material_SynNamespaceName',
                 \ { 'fg':   s:c_syntax_namespace })

" Generic context background
call s:highlight('Material_SynGeneric',
                 \ { 'bg':   s:c_syntax_meta_light })

" Interfaces (or anything that is just a declaration, but not implementation)
call s:highlight('Material_SynInterfaceKeyword',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_syntax_meta_strong })
call s:highlight('Material_SynInterfaceName',
                 \ { 'fg':   s:c_syntax_meta_strong })

" File type specific {{{5

call s:highlight('Material_SynVimCommentString',
                 \ { 'fg':   s:color_dict('green', 5) })

" Plugins {{{3
" OmniSharp | OmniSharp/omnisharp-vim {{{4

call s:highlight('Material_OmniSharpExtensionMethodName',
                 \ { 'fg':   s:color_dict('teal', 4) })
call s:highlight('Material_OmniSharpOperatorOverloaded',
                 \ { 'fg':   s:color_dict('orange', 7),
                 \   'bg':   s:color_dict('orange', 2) })
call s:highlight('Material_OmniSharpTypeParameterName',
                 \ { 'fg':   s:c_syntax_typedef,
                 \   'bg':   s:c_syntax_meta_light })
call s:highlight('Material_OmniSharpVerbatimStringLiteral',
                 \ { 'fg':   s:color_dict('green', 7),
                 \   'bg':   s:color_dict('green', 2) })

call s:highlight('Material_OmniSharpXmlDocCommentAttributeName',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('green', 3) })
call s:highlight('Material_OmniSharpXmlDocAttributeQuotes',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('green', 3) })
call s:highlight('Material_OmniSharpXmlDocCommentAttributeValue',
                 \ { 'attr': 'bold',
                 \   'fg':   s:color_dict('green', 3) })
call s:highlight('Material_OmniSharpXmlDocCommentDelimiter',
                 \ { 'fg':   s:color_dict('teal', 3) })
call s:highlight('Material_OmniSharpXmlDocCommentName',
                 \ { 'fg':   s:color_dict('orange', 3) })
call s:highlight('Material_OmniSharpXmlDocCommentText',
                 \ { 'fg':   s:c_neutral_midpoint_strong })

" vim-airline | vim-airline/vim-airline {{{4

call s:highlight('Material_Airline1',
                 \ { 'fg':   s:c_neutral_midpoint_strong,
                 \   'bg':   s:color_dict(s:hue_neutral, 2) })
call s:highlight('Material_Airline3',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:c_neutral_strong })

call s:highlight('Material_AirlineInsert',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict(s:hue_insert, 7) })
call s:highlight('Material_AirlineReplace',
                 \ { 'attr': 'bold',
                 \   'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict(s:hue_replace, 7) })

call s:highlight('Material_AirlineModified',
                 \ { 'fg':   s:c_neutral_lightest,
                 \   'bg':   s:color_dict('purple', 8) })

" Linked highlight groups {{{1
" Non-editor window highlights {{{2
" Framing {{{3

highlight! link MsgSeparator     Material_VimStrongFramingWithoutFg
highlight! link TabLineFill      Material_VimStrongFramingWithoutFg
highlight! link VertSplit        Material_VimStrongFramingWithoutFg

highlight! link FoldColumn       Material_VimLightFramingSubtleFg
highlight! link SignColumn       Material_VimLightFramingSubtleFg
highlight! link LineNr           Material_VimLightFramingSubtleFg

highlight! link ColorColumn      Material_VimLighterFraming

highlight! link CursorLineNr     Material_VimCursorLinesNum

highlight! link TabLine          Material_VimLightFramingStrongFg
highlight! link TabLineSel       Material_VimNormal
highlight! link Title            Material_VimTitle

highlight! link StatusLine       Material_VimStatusLine
highlight! link StatusLineNC     Material_VimStatusLineNC
highlight! link StatusLineTerm   Material_VimStatusLine
highlight! link StatusLineTermNC Material_VimStatusLineNC

highlight! link WildMenu         Material_VimWildMenu

" Popup menu and floating windows {{{3

highlight! link Pmenu       Material_VimPopup
highlight! link PmenuSel    Material_VimPopupSelected
highlight! link PmenuSbar   Material_VimPopupScrollbar
highlight! link PmenuThumb  Material_VimPopupThumb
highlight! link NormalFloat Material_VimPopup

" Editor window highlights {{{2
" Normal text {{{3

" for the Normal group, see the definition of Material_VimNormal
highlight! link NonText  Material_VimNormalLight
highlight! link NormalNC Material_VimNormal
highlight! link MsgArea  Material_VimNormal

" Cursor {{{3

highlight! link Cursor        Material_VimCursor
highlight! link CursorInsert  Material_VimCursorInsert
highlight! link CursorReplace Material_VimCursorReplace
highlight! link CursorIM      Material_DebugTest
highlight! link CursorColumn  Material_VimCursorLines
highlight! link CursorLine    Material_VimCursorLines
highlight! link IncSearch     Material_VimIncSearch
highlight! link MatchParen    Material_VimMatchParen
highlight! link QuickFixLine  Material_VimVisual
highlight! link Search        Material_VimSearch
highlight! link Substitute    Material_VimSearch
highlight! link TermCursor    Material_VimCursor
highlight! link TermCursorNC  Material_VimCursorUnfocused
highlight! link Visual        Material_VimVisual
highlight! link VisualNOS     Material_VimDiffLineText

" Special character visualization {{{3

highlight! link Conceal     Material_VimConceal
highlight! link EndOfBuffer Material_VimNormalLight
highlight! link SpecialKey  Material_VimSpecialKey
highlight! link Whitespace  Material_VimNormalLight

" Diff {{{3

highlight! link DiffAdd    Material_VimDiffLineAdd
highlight! link DiffChange Material_VimDiffLineChange
highlight! link DiffDelete Material_VimDiffLineDelete
highlight! link DiffText   Material_VimDiffLineText

" Spelling {{{3

highlight! link SpellBad   Material_VimSpellBad
highlight! link SpellCap   Material_VimSpellCap
highlight! link SpellLocal Material_VimSpellLocal
highlight! link SpellRare  Material_VimSpellRare

" Special items {{{2

highlight! link Directory Material_VimDirectory
highlight! link Folded    Material_VimFolded

" Messages {{{2

highlight! link ErrorMsg   Material_VimErrorInverted
highlight! link ModeMsg    Material_VimModeMsg
highlight! link MoreMsg    Material_VimMoreMsg
highlight! link Question   Material_VimMoreMsg
highlight! link WarningMsg Material_VimWarningInverted

" Syntax groups {{{2

highlight! link Comment      Material_SynComment

highlight! link Constant     Material_SynConstant
highlight! link String       Material_SynString
highlight! link Character    Material_SynCharacter
highlight! link Number       Material_SynNumber
highlight! link Boolean      Material_SynBoolean
highlight! link Float        Material_SynFloat

highlight! link Identifier   Material_SynStructureName
highlight! link Function     Material_SynFunctionName

highlight! link Statement    Material_SynStatement
highlight! link Operator     Material_SynOperator

highlight! link PreProc      Material_SynPreProc

highlight! link Type         Material_SynTypeKeyword
highlight! link StorageClass Material_SynStorageClass
highlight! link Structure    Material_SynStructureKeyword
highlight! link Typedef      Material_SynTypedefKeyword

highlight! link Special      Material_SynSpecial

highlight! link Underlined   Material_SynUnderlined

highlight! link Error        Material_VimErrorInverted

highlight! link Todo         Material_SynTodo

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
" File type highlight groups {{{2
" cs (C#) {{{3

highlight! link csBraces    Material_SynSpecial
highlight! link csClass     Material_SynTypedefKeyword
highlight! link csClassType Material_SynTypedefName
highlight! link csEndColon  Material_SynSpecial
highlight! link csGeneric   Material_SynGeneric
highlight! link csNewType   Material_SynTypedefName
highlight! link csParens    Material_SynSpecial
highlight! link csStorage   Material_SynNamespaceKeyword

" gitcommit {{{3

highlight! link gitCommitBlank    Material_VimStyleErrorUnderline
highlight! link gitcommitOverflow Material_VimStyleWarningUnderline

" java {{{3

highlight! link javaBraces     Material_SynSpecial
highlight! link javaC_         Material_SynTypedefName
highlight! link javaClassDecl  Material_SynTypedefKeyword
highlight! link javaLangObject Material_SynFunctionName
highlight! link javaParen      Material_SynSpecial
highlight! link javaR_         Material_SynTypedefName
highlight! link javaX_         Material_SynTypedefName

" vim (VimScript|VimL) {{{3

highlight! link vimCommentString Material_SynVimCommentString
highlight! link vimFunction      Material_SynFunctionName
highlight! link vimUserFunc      Material_SynFunctionName

" highlight groups for plugins {{{2
" Asynchronous Lint Engine | w0rp/ale {{{3

highlight! link ALEError                   Material_VimErrorUnderline
highlight! link ALEErrorSign               Material_VimErrorInverted
highlight! link ALEVirtualTextError        Material_VimErrorInverted

highlight! link ALEInfo                    Material_VimInfoUnderline
highlight! link ALEInfoSign                Material_VimInfoInverted
highlight! link ALEVirtualTextInfo         Material_VimInfoInverted

highlight! link ALEStyleError              Material_VimStyleErrorUnderline
highlight! link ALEStyleErrorSign          Material_VimStyleErrorInverted
highlight! link ALEVirtualTextStyleError   Material_VimStyleErrorInverted

highlight! link ALEStyleWarning            Material_VimStyleWarningUnderline
highlight! link ALEStyleWarningSign        Material_VimStyleWarningInverted
highlight! link ALEVirtualTextStyleWarning Material_VimStyleWarningInverted

highlight! link ALEWarning                 Material_VimWarningUnderline
highlight! link ALEWarningSign             Material_VimWarningInverted
highlight! link ALEVirtualTextWarning      Material_VimWarningInverted

" coc.nvim | neoclide/coc.nvim {{{3

highlight! link CocCodeLens Material_SynComment

" vim-git | tpope/vim-git {{{3

highlight! link diffAdded   Material_VimDiffAdd
highlight! link diffRemoved Material_VimDiffDelete

" Signify | mhinz/vim-signify {{{3

highlight! link SignifySignAdd             Material_VimDiffSignAdd
highlight! link SignifySignChange          Material_VimDiffSignChange
highlight! link SignifySignChangeDelete    Material_VimDiffSignChangeDelete
highlight! link SignifySignDelete          Material_VimDiffSignDelete
highlight! link SignifySignDeleteFirstLine Material_VimDiffSignDelete

highlight! link SignifyLineAdd             Material_VimDiffLineAdd
highlight! link SignifyLineChange          Material_VimDiffLineChange
highlight! link SignifyLineChangeDelete    Material_VimDiffLineChangeDelete
highlight! link SignifyLineDelete          Material_VimDiffLineDelete
highlight! link SignifyLineDeleteFirstLine Material_VimDiffLineDelete

" OmniSharp | OmniSharp/omnisharp-vim {{{3

let g:OmniSharp_highlight_groups = {
      \ 'Comment':                            'Material_SynComment',
      \ 'ExcludedCode':                       'Material_DebugTest',
      \ 'Identifier':                         'Material_SynStructureName',
      \ 'Keyword':                            'Keyword',
      \ 'ControlKeyword':                     'Conditional',
      \ 'NumericLiteral':                     'Material_SynNumber',
      \ 'Operator':                           'Material_SynOperator',
      \ 'OperatorOverloaded':                 'Material_OmniSharpOperatorOverloaded',
      \ 'PreprocessorKeyword':                'Material_SynPreProc',
      \ 'StringLiteral':                      'Material_SynString',
      \ 'WhiteSpace':                         'Material_DebugTest',
      \ 'Text':                               'Material_DebugTest',
      \ 'StaticSymbol':                       'Material_DebugTest',
      \ 'PreprocessorText':                   'Material_VimNormal',
      \ 'Punctuation':                        'Delimiter',
      \ 'VerbatimStringLiteral':              'Material_OmniSharpVerbatimStringLiteral',
      \ 'StringEscapeCharacter':              'SpecialChar',
      \ 'ClassName':                          'Material_SynTypedefName',
      \ 'DelegateName':                       'Material_DebugTest',
      \ 'EnumName':                           'Material_SynStructureKeyword',
      \ 'InterfaceName':                      'Material_SynInterfaceName',
      \ 'ModuleName':                         'Material_DebugTest',
      \ 'StructName':                         'Material_SynStructureName',
      \ 'TypeParameterName':                  'Material_OmniSharpTypeParameterName',
      \ 'FieldName':                          'Material_SynFieldName',
      \ 'EnumMemberName':                     'Material_SynStructureName',
      \ 'ConstantName':                       'Material_SynConstantName',
      \ 'LocalName':                          'Material_SynLocalName',
      \ 'ParameterName':                      'Material_SynParameterName',
      \ 'MethodName':                         'Material_SynFunctionName',
      \ 'ExtensionMethodName':                'Material_OmniSharpExtensionMethodName',
      \ 'PropertyName':                       'Material_SynAccessorName',
      \ 'EventName':                          'Material_DebugTest',
      \ 'NamespaceName':                      'Material_SynNamespaceName',
      \ 'LabelName':                          'Material_DebugTest',
      \ 'XmlDocCommentAttributeName':         'Material_OmniSharpXmlDocCommentAttributeName',
      \ 'XmlDocCommentAttributeQuotes':       'Material_OmniSharpXmlDocAttributeQuotes',
      \ 'XmlDocCommentAttributeValue':        'Material_OmniSharpXmlDocCommentAttributeValue',
      \ 'XmlDocCommentCDataSection':          'Material_OmniSharpXmlDocCommentText',
      \ 'XmlDocCommentComment':               'Material_SynComment',
      \ 'XmlDocCommentDelimiter':             'Material_OmniSharpXmlDocCommentDelimiter',
      \ 'XmlDocCommentEntityReference':       'Material_DebugTest',
      \ 'XmlDocCommentName':                  'Material_OmniSharpXmlDocCommentName',
      \ 'XmlDocCommentProcessingInstruction': 'Material_DebugTest',
      \ 'XmlDocCommentText':                  'Material_OmniSharpXmlDocCommentText',
      \ 'XmlLiteralAttributeName':            'Material_DebugTest',
      \ 'XmlLiteralAttributeQuotes':          'Material_DebugTest',
      \ 'XmlLiteralAttributeValue':           'Material_DebugTest',
      \ 'XmlLiteralCDataSection':             'Material_DebugTest',
      \ 'XmlLiteralComment':                  'Material_DebugTest',
      \ 'XmlLiteralDelimiter':                'Material_DebugTest',
      \ 'XmlLiteralEmbeddedExpression':       'Material_DebugTest',
      \ 'XmlLiteralEntityReference':          'Material_DebugTest',
      \ 'XmlLiteralName':                     'Material_DebugTest',
      \ 'XmlLiteralProcessingInstruction':    'Material_DebugTest',
      \ 'XmlLiteralText':                     'Material_DebugTest',
      \ 'RegexComment':                       'Material_DebugTest',
      \ 'RegexCharacterClass':                'Material_DebugTest',
      \ 'RegexAnchor':                        'Material_DebugTest',
      \ 'RegexQuantifier':                    'Material_DebugTest',
      \ 'RegexGrouping':                      'Material_DebugTest',
      \ 'RegexAlternation':                   'Material_DebugTest',
      \ 'RegexText':                          'Material_DebugTest',
      \ 'RegexSelfEscapedCharacter':          'Material_DebugTest',
      \ 'RegexOtherEscape':                   'Material_DebugTest',
      \}
