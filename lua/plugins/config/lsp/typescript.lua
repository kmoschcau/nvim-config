local common = require "plugins.config.lsp.common"

require("typescript").setup {
  server = {
    capabilities = common.capabilities,
    handlers = common.handlers,
    settings = {
      javascript = {
        preferences = {
          importModuleSpecifier = "relative",
          importModuleSpecifierEnding = "js",
          quoteStyle = "double",
          useAliasesForRenames = false,
        },
        referencesCodeLens = {
          enabled = true,
          showOnAllFunctions = true,
        },
        suggest = {
          completeFunctionCalls = true,
        },
      },
      typescript = {
        implementationsCodeLens = {
          enabled = true,
        },
        preferences = {
          importModuleSpecifier = "relative",
          importModuleSpecifierEnding = "js",
          quoteStyle = "double",
          useAliasesForRenames = false,
        },
        referencesCodeLens = {
          enabled = true,
          showOnAllFunctions = true,
        },
        suggest = {
          completeFunctionCalls = true,
        },
        surveys = {
          enabled = false,
        },
      },
    },
  },
}
