-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "RRethy/vim-illuminate",
  config = function()
    require("illuminate").configure {
      filetypes_denylist = {
        "fugitive",
        "lazy",
      },
    }
  end,
}
