require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  playground = {
    enable = true
  },
  query_linter = {
    enable = true
  }
}
