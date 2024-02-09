--- @type LazyPluginSpec
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    {
      "<F3>",
      "<Cmd>UndotreeToggle<CR>",
      desc = "Undotree: Toggle.",
      silent = true,
    },
  },
}
