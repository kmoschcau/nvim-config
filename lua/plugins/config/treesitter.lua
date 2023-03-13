require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "javascript", "typescript" },
  },
  playground = {
    enable = true,
  },
  query_linter = {
    enable = true,
  },
}

require("treesitter-context").setup {
  enable = true,
}
