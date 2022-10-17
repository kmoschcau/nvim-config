local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local M = {}

local function build_checkstyle_args()
  local args = { "-f", "sarif", "-c" }
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
  table.insert(args, "$FILENAME")
  return args
end

local function handle_checkstyle_output(params)
  local output = {}

  local results = params.output
      and params.output.runs
      and params.output.runs[1]
      and params.output.runs[1].results
      or {}

  if params.err then
    table.insert(output, { message = vim.trim(params.err) })
  end

  for _, result in ipairs(results) do
    for _, location in ipairs(result.locations) do
      table.insert(output, {
        row = location.physicalLocation.region.startLine,
        col = location.physicalLocation.region.startColumn,
        end_row = location.physicalLocation.region.endLine,
        end_col = location.physicalLocation.region.endColumn
            and location.physicalLocation.region.endColumn - 1,
        code = result.ruleId,
        message = result.message.text,
        severity = h.diagnostics.severities[result.level]
      })
    end
  end

  return output
end

M.diagnostics = h.make_builtin {
  name = "checkstyle",
  meta = {
    url = "https://checkstyle.org",
    description = "Checkstyle is a tool for checking Java source code for" ..
        " adherence to a Code Standard or set of validation rules (best" ..
        " practices)."
  },
  method = methods.internal.DIAGNOSTICS,
  filetypes = { "java" },
  generator_opts = {
    command = "checkstyle",
    args = build_checkstyle_args,
    format = "json_raw",
    on_output = handle_checkstyle_output
  },
  factory = h.generator_factory
}

return M
