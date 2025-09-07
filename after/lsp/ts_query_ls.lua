---@type vim.lsp.Config
return {
  init_options = {
    parser_install_directories = {
      vim.fs.joinpath(vim.fn.stdpath "data", "/lazy/nvim-treesitter/parser/"),
    },
  },
}
