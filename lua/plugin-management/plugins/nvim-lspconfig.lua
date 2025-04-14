-- selene: allow(mixed_table)
--- @type LazyPluginSpec
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
    "williamboman/mason-lspconfig.nvim",
  },
}
