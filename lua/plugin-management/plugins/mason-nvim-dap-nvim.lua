-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  ---@module "mason-nvim-dap"
  ---@type MasonNvimDapSettings
  opts = {
    automatic_installation = true,
  },
}
