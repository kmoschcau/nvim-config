local lsp = require "plugins.config.lsp"

require("lspconfig").omnisharp.setup {
  cmd = { "OmniSharp" },
  capabilities = lsp.capabilities,
  on_attach = lsp.on_attach,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  sdk_include_prereleases = false,
  analyze_open_documents_only = false,
}
