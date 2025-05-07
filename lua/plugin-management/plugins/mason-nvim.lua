-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "mason-org/mason.nvim",
  ---@type MasonSettings
  opts = {
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
  },
}
