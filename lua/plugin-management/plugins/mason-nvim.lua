local symbols = require "symbols"

local always_install = {
  "cspell", -- TODO: cspell_ls
  "typos-lsp",
}

local function install_pkg(pkg_name)
  local has_reg, reg = pcall(require, "mason-registry")
  if not has_reg or not reg.has_package(pkg_name) then
    return
  end

  local pkg = reg.get_package(pkg_name)
  if pkg:is_installed() then
    return
  end

  local notification_id = "mason_install_" .. pkg_name

  vim.notify("Installing " .. pkg_name, vim.log.levels.INFO, {
    id = notification_id,
    timeout = false,
    title = "mason.nvim",
    opts = function(notif)
      notif.icon = symbols.progress.get_dynamic_spinner()
    end,
  })
  pkg:install(nil, function(success, error_or_receipt)
    if success then
      vim.notify(
        pkg_name .. " was successfully installed.",
        vim.log.levels.INFO,
        {
          id = notification_id,
          icon = symbols.progress.done,
          title = "mason.nvim",
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
        { id = notification_id, title = "mason.nvim" }
      )
    end
  end)
end

---Install the given packages
---@param pkg_names string[] the names of the packages to install
local function install_pgks(pkg_names)
  if pkg_names == nil then
    return
  end

  for _, pkg_name in ipairs(pkg_names) do
    install_pkg(pkg_name)
  end
end

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "mason-org/mason.nvim",
  build = function()
    local has_reg, reg = pcall(require, "mason-registry")

    if not has_reg then
      return
    end

    local refresh_notification_id = "mason_nvim_registry_refresh"

    vim.notify("Refreshing registries…", vim.log.levels.INFO, {
      id = refresh_notification_id,
      timeout = false,
      title = "mason.nvim",
      opts = function(notif)
        notif.icon = symbols.progress.get_dynamic_spinner()
      end,
    })
    reg.refresh(function(success, updated_registries)
      if success then
        vim.notify(
          #updated_registries > 0
              and string.format(
                "Successfully refreshed %d registries.",
                #updated_registries
              )
            or "No registries needed refreshing.",
          vim.log.levels.INFO,
          {
            id = refresh_notification_id,
            icon = symbols.progress.done,
            title = "mason.nvim",
          }
        )
        install_pgks(always_install)
      else
        vim.notify("Could not refresh the registries.", vim.log.levels.ERROR, {
          id = refresh_notification_id,
          title = "mason.nvim",
        })
      end
    end)
  end,
  opts = {
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
  },
}
