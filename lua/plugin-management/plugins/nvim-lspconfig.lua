-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "Hoffs/omnisharp-extended-lsp.nvim",
    "folke/neoconf.nvim",
    "mfussenegger/nvim-jdtls",
    {
      "pmizio/typescript-tools.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    "saghen/blink.cmp",
    "seblyng/roslyn.nvim",
    "tris203/rzls.nvim",
  },
  config = function()
    -- HACK: These calls are only needed for as long as these servers are not
    -- yet migrated.

    local servers = {
      "astro",
      "glint",
    }

    local lspconfig = require "lspconfig"

    for _, server in ipairs(servers) do
      lspconfig[server].setup {}
    end
  end,
}
