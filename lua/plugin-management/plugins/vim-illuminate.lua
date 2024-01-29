--- @type LazyPluginSpec
return {
  "RRethy/vim-illuminate",
  config = function()
    require("illuminate").configure {
      filetypes_denylist = {
        "NvimTree",
        "fugitive",
        "lazy",
      },
    }
  end,
}
