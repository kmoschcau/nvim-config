local package =
  require("mason-registry").get_package "powershell-editor-services"

---@type vim.lsp.Config
return {
  bundle_path = package:is_installed()
      and vim.fn.expand "$MASON/packages/powershell-editor-services"
    or nil,
}
