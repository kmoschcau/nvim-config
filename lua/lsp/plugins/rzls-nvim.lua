local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)
if config.dotnet_server ~= "roslyn.nvim" then
  return
end

require("rzls").setup {
  capabilities = require("lsp.common").capabilities,
  on_attach = require "lsp.attach",
}
