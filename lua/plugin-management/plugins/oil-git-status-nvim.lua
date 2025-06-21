-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "refractalize/oil-git-status.nvim",
  dependencies = {
    -- cspell:disable
    "stevearc/oil.nvim",
    -- cspell:enable
  },
  config = true,
}
