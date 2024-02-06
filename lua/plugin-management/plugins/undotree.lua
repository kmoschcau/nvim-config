--- @type LazyPluginSpec
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    {
      "<F3>",
      ":UndotreeToggle<CR>",
      desc = "Undotree: Toggle.",
      silent = true,
    },
  },
}
