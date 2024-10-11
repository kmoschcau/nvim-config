--- @type LazyPluginSpec
return {
  "nushell/tree-sitter-nu",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  build = ":TSUpdate nu",
}