return {
  "RRethy/vim-illuminate",
  config = function()
    require("illuminate").configure {
      filetypes_denylist = {
        "NvimTree",
        "dirvish",
        "fugitive",
      },
    }
  end,
}
