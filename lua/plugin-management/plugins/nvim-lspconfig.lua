-- cspell:words lspconfig

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "neovim/nvim-lspconfig",
  dependencies = {
    -- cspell:disable
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
    -- cspell:enable
  },
  config = function()
    -- HACK: These calls are only needed for as long as these servers are not
    -- yet migrated.
    -- See: https://github.com/neovim/nvim-lspconfig/issues/3705

    local servers = {
      "glint",
    }

    local lspconfig = require "lspconfig"

    for _, server in ipairs(servers) do
      lspconfig[server].setup {}
    end
  end,
}
