require("trouble").setup {
  padding = false,
  use_diagnostic_signs = true
}

vim.keymap.set("n", "<space>t", "<cmd>TroubleToggle<cr>", {
  desc = "Toggle the current Trouble list.",
  silent = true
})
