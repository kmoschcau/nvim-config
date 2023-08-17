return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
    "williamboman/mason.nvim",
  },
  opts = {
    automatic_installation = {
      -- mason version has issues with GLIBC missing, use cargo
      exclude = { "selene" },
    },
  },
}
