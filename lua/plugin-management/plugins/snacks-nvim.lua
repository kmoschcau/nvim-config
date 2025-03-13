-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  --- @type snacks.Config
  opts = {
    --- @type table<string, snacks.win.Config>
    styles = {
      input = {
        relative = "cursor",
        row = -3,
        col = 0,
      },
    },

    image = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
  },
  init = function()
    local snacks = require "snacks"

    vim.keymap.set("n", "<Space>P", snacks.picker.pick, {
      desc = "Snacks picker: Open pickers.",
    })

    vim.keymap.set("n", "<Space>pf", function()
      snacks.picker.pick "files"
    end, { desc = "Snacks picker: Open file search." })

    vim.keymap.set("n", "<Space>pg", function()
      snacks.picker.pick "grep"
    end, { desc = "Snacks picker: Open live grep search." })
  end,
}
