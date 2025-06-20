-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  ---@module "lazydev"
  ---@type lazydev.Config
  opts = {
    ---@type lazydev.Library.spec[]
    library = {
      "luvit-meta/library",
    },
  },
}
