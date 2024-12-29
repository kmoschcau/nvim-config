local common = require "lsp.common"
local lspconfig = require "lspconfig"

lspconfig.denols.setup {
  -- https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno
  settings = {
    deno = {
      codeLens = {
        implementations = true,
        references = true,
        referencesAllFunctions = true,
      },
      inlayHints = common.js_inlay.vs_code,
    },
  },
}
