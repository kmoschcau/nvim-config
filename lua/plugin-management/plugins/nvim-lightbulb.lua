-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "kosayoda/nvim-lightbulb",
  enabled = not vim.g.use_roslyn,
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
