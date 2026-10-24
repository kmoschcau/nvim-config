require("illuminate").configure {
  filetypes_denylist = {
    "fugitive",
    "lazy",
    "mason",
    "notify",
  },
}
