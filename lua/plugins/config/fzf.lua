require 'fzf-lua'.setup {
  fzf_opts = {
    ['--layout']  = false,
    ['--prompt']  = false
  },
  fzf_colors = {
    ['fg']         = { 'fg', 'Material_VimNormal' },
    ['bg']         = { 'bg', 'Material_VimNormal' },
    ['hl']         = { 'fg', 'Material_SynSpecial' },
    ['fg+']        = { 'fg', 'Material_VimNormal' },
    ['bg+']        = { 'bg', 'Material_VimVisual' },
    ['hl+']        = { 'fg', 'Material_SynSpecial' },
    ['preview-fg'] = { 'fg', 'Material_VimNormal' },
    ['preview-bg'] = { 'bg', 'Material_VimNormal' },
    ['gutter']     = { 'bg', 'Material_VimLightFramingSubtleFg' },
    ['pointer']    = { 'fg', 'Material_VimNormal' },
    ['marker']     = { 'bg', 'Material_VimInfoInverted' },
    ['border']     = { 'bg', 'Material_VimStrongFramingWithoutFg' },
    ['info']       = { 'fg', 'Material_VimMoreMsg' },
    ['prompt']     = { 'bg', 'Material_VimStatusLine' }
  }
}
