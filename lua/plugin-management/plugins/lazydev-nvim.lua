-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  ---@type lazydev.Config
  opts = {
    ---@type lazydev.Library.spec[]
    library = {
      { path = "coerce.nvim/lua/coerce.lua", words = { "CoerceConfigUser" } },
      {
        path = "conform.nvim/lua/conform/types.lua",
        mods = { "conform" },
        words = { "conform%.setupOpts" },
      },
      {
        path = "gitsigns.nvim/lua/gitsigns/status.lua",
        words = { "Gitsigns" },
      },
      { path = "lazy.nvim/lua/lazy/types.lua", words = { "LazyPluginSpec" } },
      { path = "lazydev.nvim/lua/lazydev/config.lua", words = { "lazydev" } },
      "luvit-meta/library",
      {
        path = "mason-lspconfig.nvim/lua/mason-lspconfig/settings.lua",
        words = { "MasonLspconfigSettings" },
      },
      {
        path = "mason-nvim-dap.nvim/lua/mason-nvim-dap/settings.lua",
        words = { "MasonNvimDapSettings" },
      },
      {
        path = "mason.nvim/lua/mason-core/package/init.lua",
        words = { "Package" },
      },
      {
        path = "mason.nvim/lua/mason/settings.lua",
        words = { "MasonSettings" },
      },
      { path = "oil.nvim/lua/oil/types.lua", mods = { "oil" } },
      {
        path = "render-markdown.nvim/lua/render-markdown/init.lua",
        words = { "render%.md%.UserConfig" },
      },
      { path = "snacks.nvim/lua/snacks/init.lua", words = { "snacks" } },
      { path = "snacks.nvim/lua/snacks/win.lua", words = { "snacks%.win" } },
    },
  },
}
