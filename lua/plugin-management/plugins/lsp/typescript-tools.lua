local common = require "lsp.common"

local ts = common.settings.typescript

require("typescript-tools").setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    expose_as_code_action = "all",
    complete_function_calls = ts.suggest.completeFunctionCalls,
    code_lens = "all",
    disable_member_code_lens = false,

    tsserver_file_preferences = vim.tbl_deep_extend(
      "error",
      common.js_inlay.tsserver,
      {
        importModuleSpecifierEnding = ts.preferences.importModuleSpecifierEnding,
        importModuleSpecifierPreference = ts.preferences.importModuleSpecifier,
        quotePreference = ts.preferences.quoteStyle,
        useLabelDetailsInCompletionEntries = true,
      }
    ),

    javascript = common.settings.javascript,
    typescript = ts,
  },
}
