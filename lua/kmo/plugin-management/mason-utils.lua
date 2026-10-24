local M = {}

M.always_install = {}

if vim.fn.has "win32" == 1 then
  table.insert(M.always_install, "cspell")
else
  -- This seems to cause weird lag spikes on Windows, use it via nvim-lint
  -- instead.
  table.insert(M.always_install, "cspell-lsp")
end

local function install_pkg(pkg_name)
  local has_reg, reg = pcall(require, "mason-registry")
  if not has_reg or not reg.has_package(pkg_name) then
    return
  end

  local pkg = reg.get_package(pkg_name)
  if pkg:is_installed() or pkg:is_installing() then
    return
  end

  local id = "mason_install_" .. pkg_name
  local title = "mason.nvim"

  local symbols = require "kmo.symbols"

  vim.notify("Installing " .. pkg_name, vim.log.levels.INFO, {
    id = id,
    timeout = false,
    title = title,
    opts = function(notification)
      notification.icon = symbols.progress.get_dynamic_spinner()
    end,
  })
  pkg:install(nil, function(success, error_or_receipt)
    if success then
      vim.notify(
        pkg_name .. " was successfully installed.",
        vim.log.levels.INFO,
        {
          id = id,
          icon = symbols.progress.done,
          title = title,
        }
      )
    else
      vim.notify(
        string.format(
          "Could not install %s:\n%s",
          pkg_name,
          vim.inspect(error_or_receipt)
        ),
        vim.log.levels.ERROR,
        { id = id, title = title }
      )
    end
  end)
end

---Install the given packages
---@param pkg_names string[] the names of the packages to install
function M.install_packages(pkg_names)
  if pkg_names == nil then
    return
  end

  for _, pkg_name in ipairs(pkg_names) do
    install_pkg(pkg_name)
  end
end

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
