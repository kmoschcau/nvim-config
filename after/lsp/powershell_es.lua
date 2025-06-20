local is_installed =
  require("plugin-management.mason-utils").is_package_installed "powershell-editor-services"

---@type vim.lsp.Config
return {
  bundle_path = is_installed
      and vim.fn.expand "$MASON/packages/powershell-editor-services"
    or nil,
}
