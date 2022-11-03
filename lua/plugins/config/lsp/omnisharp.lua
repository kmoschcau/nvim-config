local lsp = require "plugins.config.lsp"

local analyze_open_documents_only = false
local import_compl = true
local load_on_demand = false
local roslyn_analyzers = true
local organize_imports = true
local incluse_prereleases = true
local use_modern = false

require("lspconfig").omnisharp.setup {
  cmd = { "OmniSharp" },
  root_dir = function()
    return "C:/Synxis/ProjectX/SHS/EnterpriseServices/"
  end,
  capabilities = lsp.capabilities,
  on_attach = lsp.on_attach,
  enable_ms_build_load_projects_on_demand = load_on_demand,
  enable_roslyn_analyzers = roslyn_analyzers,
  organize_imports_on_format = organize_imports,
  enable_import_completion = import_compl,
  sdk_include_prereleases = incluse_prereleases,
  analyze_open_documents_only = analyze_open_documents_only,
  settings = {
    omnisharp = {
      analyzeOpenDocumentsOnly = analyze_open_documents_only,
      defaultLaunchSolution = "SHS.ProfileManager.sln",
      enableImportCompletion = import_compl,
      enableMsBuildLoadProjectsOnDemand = load_on_demand,
      enableRoslynAnalyzers = roslyn_analyzers,
      organizeImportsOnFormat = organize_imports,
      sdkIncludePrereleases = incluse_prereleases,
      useModernNet = use_modern,
    },
  },
}
