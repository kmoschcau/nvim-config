local common = require "lsp.common"

local ts = common.settings.typescript

local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)

require("typescript-tools").setup {
  autostart = config.ecma_server == "typescript-tools",
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  -- https://github.com/pmizio/typescript-tools.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
  settings = {
    expose_as_code_action = "all",
    complete_function_calls = ts.suggest.completeFunctionCalls,
    code_lens = "all",
    disable_member_code_lens = false,

    tsserver_format_options = ts.format,
    tsserver_file_preferences = ts.preferences,
    tsserver_plugins = {
      -- TODO: Notify when this is not installed.
      "@vue/typescript-plugin",
    },

    javascript = common.settings.javascript,
    typescript = ts,
  },
}
