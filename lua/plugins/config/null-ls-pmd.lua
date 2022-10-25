local h = require "null-ls.helpers"
local methods = require "null-ls.methods"

local M = {}

local function build_pmd_args()
  local args =
    { "--no-cache", "--format", "json", "--dir", "$FILENAME", "--rulesets" }
  if vim.b.null_ls_java_pmd_rulesets then
    table.insert(args, vim.b.null_ls_java_pmd_rulesets)
  else
    table.insert(args, "category/java/bestpractices.xml")
  end
  return args
end

local function handle_pmd_output(params)
  local output = {}

  local results = params.output and params.output.files or {}

  if params.err then
    table.insert(output, { message = vim.trim(params.err) })
  end

  for _, result in ipairs(results) do
    for _, violation in ipairs(result.violations) do
      table.insert(output, {
        row = violation.beginline,
        col = violation.begincolumn,
        end_row = violation.endline,
        end_col = violation.endcolumn + 1,
        code = violation.ruleset .. "/" .. violation.rule,
        message = violation.description,
        severity = violation.priority == 1 and violation.priority
          or violation.priority - 1,
      })
    end
  end

  return output
end

M.diagnostics = h.make_builtin {
  name = "pmd",
  meta = {
    url = "https://pmd.github.io",
    description = "An extensible cross-language static code analyzer.",
  },
  method = methods.internal.DIAGNOSTICS_ON_SAVE,
  filetypes = { "java", "jsp" },
  generator_opts = {
    args = build_pmd_args,
    check_exit_code = { 0, 4 },
    command = "pmd",
    format = "json",
    on_output = handle_pmd_output,
    to_stdin = false,
  },
  factory = h.generator_factory,
}

return M
