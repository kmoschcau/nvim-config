local null_ls = require "null-ls"
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local local_config = require "local-config"

--- Build the extra arguments for checkstyle
--- @return string[]
local function build_checkstyle_extra_args()
  local config = local_config.get_config()

  local args = {}

  if config.null_ls.java.checkstyle.file then
    table.insert(args, "$FILENAME")
  else
    table.insert(args, "$ROOT")
  end

  table.insert(args, "-c")
  if config.null_ls.java.checkstyle.config then
    table.insert(args, config.null_ls.java.checkstyle.config)
  else
    table.insert(args, "/google_checks.xml")
  end

  if config.null_ls.java.checkstyle.options then
    for _, arg in ipairs(vim.fn.split(config.null_ls.java.checkstyle.options)) do
      table.insert(args, arg)
    end
  end

  return args
end

--- Build the extra arguments for PMD
--- @return string[]
local function build_pmd_extra_args()
  local config = local_config.get_config()

  local args = {}

  table.insert(args, "--dir")
  if config.null_ls.java.pmd.dir then
    table.insert(args, config.null_ls.java.pmd.dir)
  else
    table.insert(args, "$ROOT")
  end

  table.insert(args, "--rulesets")
  if config.null_ls.java.pmd.rulesets then
    table.insert(args, config.null_ls.java.pmd.rulesets)
  else
    table.insert(args, "category/java/bestpractices.xml")
  end

  if config.null_ls.java.pmd.cache then
    table.insert(args, "--cache")
    table.insert(args, config.null_ls.java.pmd.cache)
  else
    table.insert(args, "--no-cache")
  end

  return args
end

require("null-ls").setup {
  border = "rounded",
  diagnostics_format = "#{s}: #{m}",
  on_attach = require("plugins.config.lsp").on_attach,
  sources = {
    code_actions.eslint_d,
    code_actions.gitsigns,
    code_actions.shellcheck,

    diagnostics.checkstyle.with {
      args = { "-f", "sarif" },
      extra_args = build_checkstyle_extra_args,
      timeout = -1,
    },
    diagnostics.eslint_d,
    diagnostics.fish,
    diagnostics.markdownlint,
    diagnostics.pmd.with {
      args = { "--format", "json" },
      extra_args = build_pmd_extra_args,
      timeout = -1,
    },
    diagnostics.shellcheck,
    diagnostics.selene,
    diagnostics.stylelint,
    diagnostics.tidy,
    diagnostics.todo_comments,
    diagnostics.trail_space.with {
      disabled_filetypes = { "NvimTree", "markdown" },
    },
    diagnostics.yamllint,

    formatting.black,
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
