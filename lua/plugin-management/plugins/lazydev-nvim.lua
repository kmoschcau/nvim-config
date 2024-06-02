--- @type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      "gitsigns.nvim/lua/gitsigns/status.lua",
      "hover.nvim/lua/hover/config.lua",
      "hydrate.nvim/lua/hydrate/config.lua",
      "lazy.nvim/lua/lazy/types.lua",
      "luvit-meta/library",
      "mason-lspconfig.nvim/lua/mason-lspconfig/settings.lua",
      "mason-nvim-dap.nvim/lua/mason-nvim-dap/settings.lua",
      "mason.nvim/lua/mason-core/package/init.lua",
      "mason.nvim/lua/mason/settings.lua",
      "noice.nvim/lua/noice/config/init.lua",
      "noice.nvim/lua/noice/config/views.lua",
      "noice.nvim/lua/noice/message/router.lua",
      "noice.nvim/lua/noice/ui/cmdline.lua",
      "oil.nvim/lua/oil/types.lua",
      "trouble.nvim/lua/trouble/config/init.lua",
    },
  },
}
