-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
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
