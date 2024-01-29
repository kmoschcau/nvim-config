--- @type LazyPluginSpec
return {
  "romgrk/nvim-treesitter-context",
  event = "BufReadPre",
  opts = {
    enable = true,
  },
}
