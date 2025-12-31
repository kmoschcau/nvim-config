local common = require "kmo.lsp.common"

require "kmo.lsp.plugins.roslyn-nvim"
require "kmo.lsp.plugins.typescript-tools"

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP: Set up things when attaching with a language client to a buffer.",
  group = common.augroup,
  ---@param args LspAttachArgs
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    require "kmo.lsp.attach"(client, args.buf)
  end,
})

vim.lsp.config("*", {
  capabilities = common.capabilities,
})

vim.lsp.enable {
  -- cspell:disable
  "astro",
  "bashls",
  "cssls",
  "docker_language_server",
  "denols",
  -- "ember", -- FIXME: This spews errors into the log when no cmd present.
  "emmet_language_server",
  "fish_lsp",
  "gh_actions_ls",
  -- "glint", -- FIXME: Currently tries to start local server, even if not installed.
  "gradle_ls",
  "helm_ls",
  "html",
  "jdtls",
  "jedi_language_server",
  "jqls",
  "jsonls",
  "kotlin_language_server",
  "lemminx",
  "lua_ls",
  "marksman",
  "nushell",
  "omnisharp",
  "phpactor",
  "powershell_es",
  "prosemd_lsp",
  "quick_lint_js",
  "roslyn_ls",
  "ruff",
  "rumdl",
  "rust_analyzer",
  "stylelint_lsp",
  "somesass_ls",
  "svelte",
  "systemd_lsp",
  "tailwindcss",
  "taplo",
  "terraformls",
  "texlab",
  "tombi",
  "ts_ls",
  "ts_query_ls",
  "vale_ls",
  "vimls",
  "vtsls",
  "vue_ls",
  "yamlls",
  -- cspell:enable
}
