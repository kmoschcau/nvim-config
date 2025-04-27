-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
  },
  ---@type MasonNvimDapSettings
  opts = {
    automatic_installation = true,
  },
}
