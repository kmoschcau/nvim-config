if vim.fn.expand("%:e") == "xaml" then
  require("system-compat").set_dos_file_options()
end
