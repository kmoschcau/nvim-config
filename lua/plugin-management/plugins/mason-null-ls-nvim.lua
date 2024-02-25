--- @type LazyPluginSpec
return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "nvimtools/none-ls.nvim",
    "williamboman/mason.nvim",
  },
  -- @type MasonNullLsSettings -- Does not work well, no optional fields
  opts = {
    automatic_installation = {
      -- mason version has issues with GLIBC missing, use cargo
      exclude = { "selene" },
    },
  },
}
