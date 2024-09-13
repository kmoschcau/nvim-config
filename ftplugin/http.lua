vim.keymap.set("n", "<Space>rr", "<Cmd>Rest run<CR>", {
  buffer = true,
  silent = true,
  desc = "rest.nvim: Run the request under the cursor.",
})

vim.keymap.set("n", "<Space>rse", "<Cmd>Telescope rest select_env<CR>", {
  buffer = true,
  silent = true,
  desc = "rest.nvim: Select an environment with Telescope.",
})
