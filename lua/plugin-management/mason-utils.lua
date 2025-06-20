local M = {}

---Check whether a given package is installed via mason.nvim.
---@param package_name string the name of the package to check
---@return boolean installed whether the package is installed
function M.is_package_installed(package_name)
  local has_registry, registry = pcall(require, "mason-registry")

  return has_registry
    and registry.has_package(package_name)
    and registry.get_package(package_name):is_installed()
end

return M
