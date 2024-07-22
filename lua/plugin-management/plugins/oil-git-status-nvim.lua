--- @type LazyPluginSpec
return {
  "refractalize/oil-git-status.nvim",
  enabled = vim.fn.has "win32" == 0,
  dependencies = { "stevearc/oil.nvim" },
  config = true,
}
