require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    custom_captures = {
      ['accessor.keyword'] = 'TSAccessorKeyword',
      ['accessor.name'] = 'TSAccessorName',
      ['class.keyword'] = 'TSClassKeyword',
      ['class.name'] = 'TSClassName',
      ['enum.keyword'] = 'TSEnumKeyword',
      ['enum.name'] = 'TSEnumName',
      ['function.keyword'] = 'TSFunctionKeyword',
      ['function.name'] = 'TSFunctionName',
      ['generic'] = 'TSGeneric',
      ['generic.special'] = 'TSGenericSpecial',
      ['interface.keyword'] = 'TSInterfaceKeyword',
      ['interface.name'] = 'TSInterfaceName',
      ['local.name'] = 'TSLocalName',
      ['namespace.keyword'] = 'TSNamespaceKeyword',
      ['namespace.name'] = 'TSNamespaceName'
    },
    additional_vim_regex_highlighting = false
  },
  playground = {
    enable = true
  },
  query_linter = {
    enable = true
  }
}

require 'treesitter-context.config'.setup {
  enable = true
}
