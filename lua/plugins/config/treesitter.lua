require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = false
  },
  playground = {
    enable = true
  },
  query_linter = {
    enable = true
  }
}

require 'nvim-treesitter.highlight'.set_custom_captures {
  ['accessor.keyword'] = 'TSAccessorKeyword',
  ['accessor.name'] = 'TSAccessorName',
  ['class.keyword'] = 'TSClassKeyword',
  ['class.name'] = 'TSClassName',
  ['enum.keyword'] = 'TSEnumKeyword',
  ['enum.name'] = 'TSEnumName',
  ['function.keyword'] = 'TSFunctionKeyword',
  ['function.name'] = 'TSFunctionName',
  ['generic.special'] = 'TSGenericSpecial',
  ['interface.keyword'] = 'TSInterfaceKeyword',
  ['interface.name'] = 'TSInterfaceName',
  ['local.name'] = 'TSLocalName',
  ['namespace.keyword'] = 'TSNamespaceKeyword',
  ['namespace.name'] = 'TSNamespaceName'
}

require 'treesitter-context.config'.setup {
  enable = true
}
