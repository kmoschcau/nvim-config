--- @type LazyPluginSpec
return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "nvimtools/none-ls.nvim",
    "williamboman/mason.nvim",
  },
  --- @type MasonNullLsSettings
  opts = {
    automatic_installation = {
      -- mason version has issues with GLIBC missing, use cargo
      exclude = { "selene" },
    },
  },
}
