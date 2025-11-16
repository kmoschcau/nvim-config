if vim.fn.expand "%:e" == "xaml" then
  require("kmo.system-compat").set_dos_file_options()
end
