-- cspell:words matchparen

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "andymass/vim-matchup",
  ---@module "match-up"
  ---@type matchup.Config
  opts = {
    matchparen = {
      offscreen = {
        border = "none",
        method = "popup",
      },
    },
  },
}
