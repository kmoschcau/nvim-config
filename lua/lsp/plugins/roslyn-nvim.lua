local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)

if config.dotnet_server ~= "roslyn.nvim" then
  return
end

require "lsp.plugins.rzls-nvim"
require("roslyn").setup {
  filewatching = "off",
}
