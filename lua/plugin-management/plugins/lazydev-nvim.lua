--- @type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      "conform.nvim/lua/conform/types.lua",
      "gitsigns.nvim/lua/gitsigns/status.lua",
      "hydrate.nvim/lua/hydrate/config.lua",
      "lazy.nvim/lua/lazy/types.lua",
      "luvit-meta/library",
      "markdown.nvim-render/lua/render-markdown/init.lua",
      "mason-lspconfig.nvim/lua/mason-lspconfig/settings.lua",
      "mason-nvim-dap.nvim/lua/mason-nvim-dap/settings.lua",
      "mason.nvim/lua/mason-core/package/init.lua",
      "mason.nvim/lua/mason/settings.lua",
      "oil.nvim/lua/oil/types.lua",
      "trouble.nvim/lua/trouble/config/init.lua",
    },
  },
}
