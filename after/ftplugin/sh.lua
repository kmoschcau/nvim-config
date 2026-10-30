local shiftwidth = 4

vim.opt_local.listchars:append(
  require("kmo.indent-markers").get_leadmultispace(shiftwidth)
)
vim.opt_local.shiftwidth = shiftwidth
vim.opt_local.shiftwidth = 4
