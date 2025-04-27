local common = require "lsp.common"
local ts = common.settings.typescript

--- @type vim.lsp.Config
return {
  -- https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno
  settings = {
    deno = {
      codeLens = {
        implementations = ts.implementationsCodeLens.enabled,
        references = ts.referencesCodeLens.enabled,
        referencesAllFunctions = ts.referencesCodeLens.showOnAllFunctions,
      },
      inlayHints = common.ts_inlay_vs_code_settings,
    },
  },
}
