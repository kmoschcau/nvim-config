local common = require "lsp.common"

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP: Set up things when attaching with a language client to a buffer.",
  group = common.augroup,
  ---@param args LspAttachArgs
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    require "lsp.attach"(client, args.buf)
  end,
})

vim.lsp.config("*", {
  capabilities = common.capabilities,
})

vim.lsp.enable {
  "astro",
  "bashls",
  "cssls",
  "denols",
  "ember",
  "eslint",
  "fish_lsp",
  "gh_actions_ls",
  "gradle_ls",
  "helm_ls",
  "html",
  "jedi_language_server",
  "jqls",
  "jsonls",
  "kotlin_language_server",
  "lemminx",
  "lua_ls",
  "marksman",
  "omnisharp",
  "phpactor",
  "powershell_es",
  "prosemd_lsp",
  "quick_lint_js",
  "roslyn_ls",
  "ruff",
  "rust_analyzer",
  "stylelint_lsp",
  "somesass_ls",
  "svelte",
  "tailwindcss",
  "terraformls",
  "texlab",
  "ts_ls",
  "typos_lsp",
  "vale_ls",
  "vimls",
  "vue_ls",
  "yamlls",
}

require "lsp.plugins.typescript-tools"
require "lsp.plugins.rzls-nvim"
require "lsp.plugins.roslyn-nvim"
