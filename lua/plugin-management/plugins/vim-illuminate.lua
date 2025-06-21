-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "RRethy/vim-illuminate",
  config = function()
    require("illuminate").configure {
      filetypes_denylist = {
        "fugitive",
        "lazy",
        "mason",
        "notify",
      },
    }
  end,
}
