-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "mbbill/undotree",
  enabled = vim.fn.has "win32" == 0,
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
