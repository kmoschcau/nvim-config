-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "zapling/mason-conform.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "stevearc/conform.nvim",
  },
}
