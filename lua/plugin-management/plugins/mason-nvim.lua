-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "mason-org/mason.nvim",
  opts = {
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
  },
}
