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
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local common = require "lsp.common"
    local lspconfig = require "lspconfig"

    local simple_servers = {
      "bashls",
      "fish_lsp",
      "gradle_ls",
      "helm_ls",
      "jedi_language_server",
      "jqls",
      "lemminx",
      "marksman",
      "prosemd_lsp",
      "quick_lint_js",
      "ruff_lsp",
      "somesass_ls",
      "terraformls",
      "texlab",
      "vale_ls",
      "vimls",
    }

    if vim.fn.has "win32" == 0 then
      -- phpactor is simply not supported on Windows.
      table.insert(simple_servers, "phpactor")
    end

    for _, lsp in ipairs(simple_servers) do
      lspconfig[lsp].setup {
        capabilities = common.capabilities,
        handlers = common.handlers,
      }
    end

    local server_config_modules = {
      "cssls",
      "ember",
      "eslint",
      "glint",
      "html",
      "jsonls",
      "kotlin_language_server",
      "lua_ls",
      "omnisharp",
      "rust-analyzer",
      "stylelint-lsp",
      "svelte",
      "tailwindcss",
      "typescript-tools",
      "typos_lsp",
      "volar",
      "yamlls",
    }

    for _, module_name in ipairs(server_config_modules) do
      require("plugin-management.plugins.lsp." .. module_name)
    end
  end,
}
