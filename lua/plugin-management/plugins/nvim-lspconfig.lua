return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "Hoffs/omnisharp-extended-lsp.nvim",
    "folke/neodev.nvim",
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
    local local_config = require "local-config"
    local lspconfig = require "lspconfig"

    local simple_servers = {
      "bashls",
      "gradle_ls",
      "helm_ls",
      "jedi_language_server",
      "jqls",
      "kotlin_language_server",
      "lemminx",
      "ruff_lsp",
      "texlab",
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
      "emmet",
      "glint",
      "html",
      "jsonls",
      "lua_ls",
      "omnisharp",
      "svelte",
      "tailwindcss",
      "yamlls",
    }

    table.insert(
      server_config_modules,
      local_config.get_config().lsp.use_volar and "volar" or "typescript-tools"
    )

    for _, module_name in ipairs(server_config_modules) do
      require("plugin-management.plugins.lsp." .. module_name)
    end
  end,
}
