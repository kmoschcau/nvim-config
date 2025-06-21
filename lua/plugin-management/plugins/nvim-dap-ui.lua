-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "rcarriga/nvim-dap-ui",
  dependencies = {
    -- cspell:disable
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    -- cspell:enable
  },
  config = true,
}
