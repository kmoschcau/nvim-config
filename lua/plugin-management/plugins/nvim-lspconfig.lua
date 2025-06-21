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
}
