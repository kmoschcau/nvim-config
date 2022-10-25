local null_ls = require "null-ls"

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local function build_checkstyle_extra_args()
  local args = { "-c" }

  if vim.b.null_ls_java_checkstyle_config then
    table.insert(args, vim.b.null_ls_java_checkstyle_config)
  else
    table.insert(args, "/google_checks.xml")
  end

  if vim.b.null_ls_java_checkstyle_options then
    for _, arg in ipairs(vim.fn.split(vim.b.null_ls_java_checkstyle_options)) do
      table.insert(args, arg)
    end
  end

  return args
end

require("null-ls").setup {
  diagnostics_format = "#{s}: #{c} - #{m}",
  on_attach = require("plugins.config.lsp").on_attach,
  sources = {
    code_actions.eslint_d,
    code_actions.gitsigns,
    code_actions.shellcheck,

    diagnostics.checkstyle.with {
      args = { "-f", "sarif", "$FILENAME" },
      extra_args = build_checkstyle_extra_args,
    },
    diagnostics.eslint_d,
    diagnostics.fish,
    diagnostics.markdownlint,
    require("plugins.config.null-ls-pmd").diagnostics,
    diagnostics.shellcheck,
    diagnostics.selene,
    diagnostics.stylelint,
    diagnostics.tidy,
    diagnostics.todo_comments,
    diagnostics.trail_space.with {
      disabled_filetypes = { "NvimTree", "markdown" },
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
    formatting.stylua,
    formatting.tidy,
    formatting.trim_newlines,
    formatting.trim_whitespace,
  },
}
