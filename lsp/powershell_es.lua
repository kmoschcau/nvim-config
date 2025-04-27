local package =
  require("mason-registry").get_package "powershell-editor-services"

return {
  bundle_path = package:is_installed() and package:get_install_path() or nil,
}
