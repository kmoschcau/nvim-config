--- @type LazyPluginSpec
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    {
      "<F3>",
      ":UndotreeToggle<cr>",
      desc = "Undotree: Toggle.",
      silent = true,
    },
  },
}
