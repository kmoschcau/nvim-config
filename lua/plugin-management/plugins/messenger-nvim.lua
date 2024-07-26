--- @type LazyPluginSpec
return {
  "lsig/messenger.nvim",
  opts = {
    border = "rounded",
  },
  init = function()
    vim.keymap.set("n", "<Space>cm", require("messenger").show, {
      desc = "messenger.nvim: Show the commit message under the cursor.",
    })
  end,
}
