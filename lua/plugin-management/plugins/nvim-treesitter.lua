-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = function()
    pcall(vim.cmd, "TSUpdate")
  end,
  config = function()
    require("nvim-treesitter").install { "comment", "printf", "regex" }
  end,
}
