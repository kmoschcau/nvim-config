---A list of languages, that should always be installed.
local base_languages = { "comment", "lua", "printf", "regex" }

---Check if the given languages are already installed.
---@param languages_to_check string[]
---@return boolean
local function languages_installed(languages_to_check)
  local installed_languages = require("nvim-treesitter").get_installed()

  for _, language in ipairs(languages_to_check) do
    if not vim.list_contains(installed_languages, language) then
      return false
    end
  end

  return true
end

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = function()
    local notification_id = "nvim-treesitter update"
    local title = "nvim-treesitter update"
    local symbols = require "kmo.symbols"

    vim.notify("Updating languages.", vim.log.levels.INFO, {
      id = notification_id,
      timeout = false,
      title = title,
      opts = function(notification)
        notification.icon = symbols.progress.get_dynamic_spinner()
      end,
    })
    require("nvim-treesitter").update():await(function()
      vim.notify("Updated languages.", vim.log.levels.INFO, {
        id = notification_id,
        icon = symbols.progress.done,
        title = title,
      })
    end)
  end,
  config = function()
    local notification_id = "nvim-treesitter install base"
    local title = "nvim-treesitter install"
    local symbols = require "kmo.symbols"

    if languages_installed(base_languages) then
      vim.notify(
        vim.inspect(base_languages) .. " are already installed.",
        vim.log.levels.DEBUG,
        { title = title }
      )
      return
    end

    vim.notify(
      "Installing " .. vim.inspect(base_languages),
      vim.log.levels.INFO,
      {
        id = notification_id,
        timeout = false,
        title = title,
        opts = function(notification)
          notification.icon = symbols.progress.get_dynamic_spinner()
        end,
      }
    )
    require("nvim-treesitter").install(base_languages):await(function()
      vim.notify(
        "Installed " .. vim.inspect(base_languages),
        vim.log.levels.INFO,
        {
          id = notification_id,
          icon = symbols.progress.done,
          title = title,
        }
      )
    end)
  end,
}
