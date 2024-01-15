local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

--- @type NeoconfLsp
local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)

lspconfig.volar.setup {
  autostart = config.use_volar,
  cmd = { compat.append_win_ext "vue-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
}
