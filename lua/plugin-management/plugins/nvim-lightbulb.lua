-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "kosayoda/nvim-lightbulb",
  opts = {
    autocmd = {
      enabled = true,
    },
    code_lenses = true,
    ignore = {
      ft = { "razor" },
    },
  },
}
