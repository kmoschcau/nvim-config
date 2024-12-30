local common = require "lsp.common"
local lspconfig = require "lspconfig"

local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)

lspconfig.denols.setup {
  autostart = config.ecma_server == "denols",
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
