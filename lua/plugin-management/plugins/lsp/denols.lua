local common = require "lsp.common"
local lspconfig = require "lspconfig"

local ts = common.settings.typescript

local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)

lspconfig.denols.setup {
  autostart = config.ecma_server == "denols",
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
