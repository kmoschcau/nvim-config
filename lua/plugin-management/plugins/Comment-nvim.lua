--- @type LazyPluginSpec
return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
    vim.keymap.del("x", "gc")
    vim.keymap.set("x", "gcc", "<Plug>(comment_toggle_linewise_visual)", {
      desc = "Comment: Toggle linewise (visual)",
    })
  end,
}
