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

    input = { enabled = true },
    picker = { enabled = true },
  },
}
