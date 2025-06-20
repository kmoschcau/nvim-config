-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "cshuaimin/ssr.nvim",
  config = function()
    local ssr = require "ssr"
    ssr.setup {}

    vim.keymap.set({ "n", "x" }, "<Space>sr", ssr.open, {
      desc = "SSR: Open structural search and replace.",
    })
  end,
}
