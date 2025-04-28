local augroup = vim.api.nvim_create_augroup("InitNvimTerminal", {})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Adjust settings to make more sense in a terminal.",
  group = augroup,
  callback = function()
    vim.opt_local.colorcolumn = { "" }
    vim.opt_local.signcolumn = "yes:2"
    vim.opt_local.spell = false
  end,
})
