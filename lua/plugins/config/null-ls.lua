local null_ls = require("null-ls")

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

require("null-ls").setup {
  debug = true,
  diagnostics_format = "#{s}: #{c} - #{m}",
  on_attach = require("plugins.config.lsp").on_attach,
  sources = {
    code_actions.eslint_d,
    code_actions.shellcheck,

    diagnostics.eslint_d,
    diagnostics.fish,
    diagnostics.markdownlint,
    diagnostics.shellcheck,
    diagnostics.stylelint,
    diagnostics.tidy,
    diagnostics.todo_comments,
    diagnostics.trail_space.with {
      disabled_filetypes = { "NvimTree", "markdown" }
    },
    diagnostics.yamllint,

    formatting.eslint_d,
    formatting.fish_indent,
    formatting.google_java_format,
    formatting.jq,
    formatting.markdownlint,
    formatting.packer,
    formatting.shfmt,
    formatting.stylelint,
    formatting.trim_newlines,
    formatting.trim_whitespace
  }
}
