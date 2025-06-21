-- cspell:words azcli csharpierignore gotmpl nswag

local function is_cloud_formation(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local found_resources = false
  for _, line in ipairs(lines) do
    if line:match '%s*"?AWSTemplateFormatVersion"?%s*:' then
      return true
    end

    if line:match '"?Resources"?%s*:' then
      found_resources = true
    end

    if
      found_resources
      and line:match '"?Type"?%s*:%s*"?\'?AWS::%w+::%w+"?\'?'
    then
      return true
    end
  end

  return false
end

---Creates a filetype check function to determine if the given filetype is the
---original plus CloudFormation.
---@param filetype string the base filetype to use
---@return fun(path: string, bufnr: number): string func the check function
local function with_cloud_formation(filetype)
  return function(_, bufnr)
    if is_cloud_formation(bufnr) then
      return filetype .. ".cloudformation"
    end

    return filetype
  end
end

vim.filetype.add {
  extension = {
    azcli = "ps1",
    gotmpl = "gotmpl",
    json = with_cloud_formation "json",
    nswag = "json",
    yaml = with_cloud_formation "yaml",
    yml = with_cloud_formation "yaml",
  },
  filename = {
    [".csharpierignore"] = "gitignore",
    ["quick-lint-js.config"] = "json",
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
}
