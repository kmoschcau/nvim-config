-- cspell:words FIXIT OPTIM

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX = {
        icon = require("kmo.symbols").todo.fix,
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = require("kmo.symbols").todo.todo, color = "info" },
      HACK = { icon = require("kmo.symbols").todo.hack, color = "warning" },
      WARN = {
        icon = require("kmo.symbols").todo.warn,
        color = "warning",
        alt = { "WARNING", "XXX" },
      },
      PERF = {
        icon = require("kmo.symbols").todo.perf,
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
      },
      NOTE = {
        icon = require("kmo.symbols").todo.note,
        color = "hint",
        alt = { "INFO" },
      },
      TEST = {
        icon = require("kmo.symbols").todo.test,
        color = "test",
        alt = { "TESTING", "PASSED", "FAILED" },
      },
    },
  },
}
