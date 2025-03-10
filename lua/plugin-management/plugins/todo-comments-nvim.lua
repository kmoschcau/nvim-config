-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX = {
        icon = require("symbols").todo.fix,
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = require("symbols").todo.todo, color = "info" },
      HACK = { icon = require("symbols").todo.hack, color = "warning" },
      WARN = {
        icon = require("symbols").todo.warn,
        color = "warning",
        alt = { "WARNING", "XXX" },
      },
      PERF = {
        icon = require("symbols").todo.perf,
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
      },
      NOTE = {
        icon = require("symbols").todo.note,
        color = "hint",
        alt = { "INFO" },
      },
      TEST = {
        icon = require("symbols").todo.test,
        color = "test",
        alt = { "TESTING", "PASSED", "FAILED" },
      },
    },
  },
}
