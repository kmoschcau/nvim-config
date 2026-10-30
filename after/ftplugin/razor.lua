require("kmo.system-compat").set_dos_file_options()

local shiftwidth = 4

vim.opt_local.listchars:append(
  require("kmo.indent-markers").get_leadmultispace(shiftwidth)
)
vim.opt_local.shiftwidth = shiftwidth
vim.opt_local.tabstop = 4
vim.opt_local.textwidth = 120
