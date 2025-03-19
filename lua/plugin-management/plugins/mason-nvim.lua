-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "williamboman/mason.nvim",
  --- @type MasonSettings
  opts = {
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
    ui = {
      border = "rounded", -- TODO: winborder
    },
  },
}
