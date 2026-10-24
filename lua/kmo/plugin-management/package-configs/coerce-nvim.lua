require("coerce").setup()

vim.keymap.set("n", "<Space>cc", "<Plug>(coerce-normal)", {
  desc = "coerce.nvim: Coerce word",
})

vim.keymap.set("n", "<Space>cr", "<Plug>(coerce-motion)", {
  desc = "coerce.nvim: Coerce motion",
})

vim.keymap.set("x", "<Space>cr", "<Plug>(coerce-visual)", {
  desc = "coerce.nvim: Coerce selection",
})
