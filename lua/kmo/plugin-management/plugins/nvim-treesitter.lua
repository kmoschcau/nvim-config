---Check if the given languages are already installed.
---@param base_langs string[]
---@return boolean
local function base_langs_installed(base_langs)
  local installed = require("nvim-treesitter").get_installed()

  for _, base_lang in ipairs(base_langs) do
    if not vim.list_contains(installed, base_lang) then
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

    local base_langs = { "comment", "lua", "printf", "regex" }
    if base_langs_installed(base_langs) then
      vim.notify(
        vim.inspect(base_langs) .. " are already installed.",
        vim.log.levels.DEBUG,
        { title = title }
      )
      return
    end

    vim.notify("Installing " .. vim.inspect(base_langs), vim.log.levels.INFO, {
      id = notification_id,
      timeout = false,
      title = title,
      opts = function(notification)
        notification.icon = symbols.progress.get_dynamic_spinner()
      end,
    })
    require("nvim-treesitter").install(base_langs):await(function()
      vim.notify("Installed " .. vim.inspect(base_langs), vim.log.levels.INFO, {
        id = notification_id,
        icon = symbols.progress.done,
        title = title,
      })
    end)
  end,
}
