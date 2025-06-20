-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = true,
}
