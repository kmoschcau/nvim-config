-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "rcarriga/nvim-notify",
  config = function()
    local icons = require("symbols").log

    local notify = require "notify"
    notify.setup {
      icons = {
        ERROR = icons.error,
        WARN = icons.warn,
        INFO = icons.info,
        DEBUG = icons.debug,
        TRACE = icons.trace,
      },
    }

    vim.notify = notify
  end,
}
