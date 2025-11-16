-- cspell:words undotree

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
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
