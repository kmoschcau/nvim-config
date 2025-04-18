local common = require "lsp.common"

--- @class LspAttachData
--- @field client_id number the number of the LSP client

--- @class LspAttachArgs: EventArgs
--- @field data LspAttachData the LspAttach specific data

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP: Set up things when attaching with a language client to a buffer.",
  group = common.augroup,
  --- @param args LspAttachArgs the autocmd args
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    require "lsp.attach"(client, args.buf)
  end,
})

vim.lsp.config("*", {
  capabilities = common.capabilities,
})

vim.lsp.enable {
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
  "phpactor",
  "powershell_es",
  "prosemd_lsp",
  "quick_lint_js",
  "ruff",
  "rust_analyzer",
  "stylelint_lsp",
  "somesass_ls",
  "svelte",
  "terraformls",
  "texlab",
  "typos_lsp",
  "vale_ls",
  "vimls",
  "yamlls",
}

local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)

vim.lsp.enable("denols", config.ecma_server == "denols")
vim.lsp.enable("omnisharp", config.dotnet_server == "omnisharp")
vim.lsp.enable("ts_ls", config.ecma_server == "ts_ls")

if config.ecma_server == "typescript-tools" then
  require "lsp.plugins.typescript-tools"
end

if config.dotnet_server == "roslyn" then
  require "lsp.plugins.roslyn"
  require "lsp.plugins.rzls"
end
