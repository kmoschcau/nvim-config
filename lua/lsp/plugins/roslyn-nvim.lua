-- cspell:words filewatching neoconf rzls

local has_neoconf, neoconf = pcall(require, "neoconf")

local config = has_neoconf
    and neoconf.get("lsp", require("neoconf-schemas.lsp").defaults)
  or {}

if config.dotnet_server ~= "roslyn.nvim" then
  return
end

require "lsp.plugins.rzls-nvim"
require("roslyn").setup {
  filewatching = "off",
}
