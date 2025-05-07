-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  ---@type MasonNvimDapSettings
  opts = {
    automatic_installation = true,
  },
}
