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
    "https://codeberg.org/mfussenegger/nvim-jdtls",
    {
      "pmizio/typescript-tools.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    "saghen/blink.cmp",
    "seblyng/roslyn.nvim",
    -- cspell:enable
  },
}
