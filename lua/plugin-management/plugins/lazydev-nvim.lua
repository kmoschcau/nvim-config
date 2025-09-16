-- cspell:words lazydev luvit

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "folke/lazydev.nvim",
  ft = "lua",
  dependencies = {
    { "DrKJeff16/wezterm-types", lazy = true },
  },
  ---@module "lazydev"
  ---@type lazydev.Config
  opts = {
    ---@type lazydev.Library.spec[]
    library = {
      "luvit-meta/library",
      { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
}
