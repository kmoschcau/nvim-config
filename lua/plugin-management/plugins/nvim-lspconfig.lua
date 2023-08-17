return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "Hoffs/omnisharp-extended-lsp.nvim",
    "folke/neodev.nvim",
    "jose-elias-alvarez/typescript.nvim",
    "mfussenegger/nvim-jdtls",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local common = require "lsp.common"
    local lspconfig = require "lspconfig"

    local simple_servers = {
      "gradle_ls",
      "jedi_language_server",
      "lemminx",
      "phpactor",
      "ruff_lsp",
      "svelte",
      "vimls",
    }

    for _, lsp in ipairs(simple_servers) do
      lspconfig[lsp].setup {
        capabilities = common.capabilities,
        handlers = common.handlers,
      }
    end

    local server_config_modules = {
      "cssls",
      "ember",
      "glint",
      "html",
      "jsonls",
      "lua_ls",
      "omnisharp",
      "typescript",
      "yamlls",
    }
    for _, module_name in ipairs(server_config_modules) do
      require("plugin-management.plugins.lsp." .. module_name)
    end
  end,
}
