-- FIXME: This does not seem to work at all.
require("lspconfig").powershell_es.setup {
  bundle_path = vim.fn.stdpath "data"
    .. "/mason/packages/powershell-editor-services",
}
