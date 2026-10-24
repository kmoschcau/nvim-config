-- cspell:words autotag textobjects textobject

require("nvim-treesitter-textobjects").setup {
  move = {
    set_jumps = true,
  },
  select = {
    lookahead = true,
  },
}

local move = require "nvim-treesitter-textobjects.move"

vim.keymap.set({ "n", "x", "o" }, "]m", function()
  move.goto_next_start "@function.outer"
end, { desc = "treesitter-textobjects: Next function start" })

vim.keymap.set({ "n", "x", "o" }, "[m", function()
  move.goto_previous_start "@function.outer"
end, { desc = "treesitter-textobjects: Previous function start" })

vim.keymap.set({ "n", "x", "o" }, "]M", function()
  move.goto_next_end "@function.outer"
end, { desc = "treesitter-textobjects: Next function end" })

vim.keymap.set({ "n", "x", "o" }, "[M", function()
  move.goto_previous_end "@function.outer"
end, { desc = "treesitter-textobjects: Previous function end" })

vim.keymap.set({ "n", "x", "o" }, "]]", function()
  move.goto_next_start "@class.outer"
end, { desc = "treesitter-textobjects: Next class start" })

vim.keymap.set({ "n", "x", "o" }, "[[", function()
  move.goto_previous_start "@class.outer"
end, { desc = "treesitter-textobjects: Previous class start" })

vim.keymap.set({ "n", "x", "o" }, "][", function()
  move.goto_next_end "@class.outer"
end, { desc = "treesitter-textobjects: Next class end" })

vim.keymap.set({ "n", "x", "o" }, "[]", function()
  move.goto_previous_end "@class.outer"
end, { desc = "treesitter-textobjects: Previous class end" })

local select = require "nvim-treesitter-textobjects.select"

vim.keymap.set({ "x", "o" }, "am", function()
  select.select_textobject "@function.outer"
end, { desc = "treesitter-textobjects: Select outer function" })

vim.keymap.set({ "x", "o" }, "im", function()
  select.select_textobject "@function.inner"
end, { desc = "treesitter-textobjects: Select inner function" })

vim.keymap.set({ "x", "o" }, "ac", function()
  select.select_textobject "@class.outer"
end, { desc = "treesitter-textobjects: Select outer class" })

vim.keymap.set({ "x", "o" }, "ic", function()
  select.select_textobject "@class.inner"
end, { desc = "treesitter-textobjects: Select inner class" })

local swap = require "nvim-treesitter-textobjects.swap"

vim.keymap.set("n", "<Space>]p", function()
  swap.swap_next "@parameter.inner"
end, { desc = "treesitter-textobjects: Swap with next parameter" })

vim.keymap.set("n", "<Space>[p", function()
  swap.swap_previous "@parameter.inner"
end, { desc = "treesitter-textobjects: Swap with previous parameter" })

---A list of languages, that should always be installed.
local base_languages = {
  "comment",
  "ecma",
  "html_tags",
  "jsx",
  "lua",
  "printf",
  "regex",
  "sql",
  "vim",
  "vimdoc",
}

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

vim.notify("Installing " .. vim.inspect(base_languages), vim.log.levels.INFO, {
  id = notification_id,
  timeout = false,
  title = title,
  opts = function(notification)
    notification.icon = symbols.progress.get_dynamic_spinner()
  end,
})
require("nvim-treesitter").install(base_languages):await(function()
  vim.notify("Installed " .. vim.inspect(base_languages), vim.log.levels.INFO, {
    id = notification_id,
    icon = symbols.progress.done,
    title = title,
  })
end)

require("nvim-ts-autotag").setup()
