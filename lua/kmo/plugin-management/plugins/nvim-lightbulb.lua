-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
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
