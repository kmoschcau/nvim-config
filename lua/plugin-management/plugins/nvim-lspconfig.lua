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
    "seblj/roslyn.nvim",
    "tris203/rzls.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local common = require "lsp.common"
    local lspconfig = require "lspconfig"

    lspconfig.util.default_config =
      vim.tbl_extend("force", lspconfig.util.default_config, {
        capabilities = common.capabilities,
      })

    local simple_servers = {
      "astro",
      "bashls",
      "fish_lsp",
      "gradle_ls",
      "helm_ls",
      "jedi_language_server",
      "jqls",
      "lemminx",
      "marksman",
      "ocamllsp",
      "prosemd_lsp",
      "quick_lint_js",
      "ruff",
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
      lspconfig[lsp].setup {}
    end

    local server_config_modules = {
      "cssls",
      "denols",
      "eslint",
      "glint",
      "html",
      "jsonls",
      "kotlin_language_server",
      "lua_ls",
      "powershell_es",
      "rust-analyzer",
      "stylelint-lsp",
      "svelte",
      "tailwindcss",
      "typescript-tools",
      "typos_lsp",
      "volar",
      "yamlls",
    }

    if vim.g.use_roslyn then
      table.insert(server_config_modules, "roslyn")
      table.insert(server_config_modules, "rzls")
    else
      table.insert(server_config_modules, "omnisharp")
    end

    for _, module_name in ipairs(server_config_modules) do
      require("plugin-management.plugins.lsp." .. module_name)
    end
  end,
}
