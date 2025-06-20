local has_neoconf, neoconf = pcall(require, "neoconf")

local config =
  has_neoconf and neoconf.get("lsp", require("neoconf-schemas.lsp").defaults) or {}

if config.dotnet_server ~= "roslyn.nvim" then
  return
end

require("rzls").setup {
  capabilities = require("lsp.common").capabilities,
  on_attach = require "lsp.attach",
}
