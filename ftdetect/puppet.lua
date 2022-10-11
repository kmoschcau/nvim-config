local augroup = vim.api.nvim_create_augroup("FtdetectPuppet", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "*.pp",
  callback = function () vim.cmd([[setfiletype puppet]]) end
})
