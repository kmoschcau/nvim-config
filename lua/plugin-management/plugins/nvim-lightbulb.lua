--- @type LazyPluginSpec
return {
  "kosayoda/nvim-lightbulb",
  opts = {
    autocmd = {
      enabled = true,
    },
    code_lenses = true,
    ignore = {
      clients = { "null-ls" },
    },
  },
}
