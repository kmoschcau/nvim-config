return {
  "cshuaimin/ssr.nvim",
  config = function()
    local ssr = require "ssr"
    ssr.setup {}

    vim.keymap.set({ "n", "x" }, "<space>sr", ssr.open, {
      desc = "Open structural search and replace.",
    })
  end,
}
