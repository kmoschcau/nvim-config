local has_neoconf, neoconf = pcall(require, "neoconf")

local config = has_neoconf
    and neoconf.get("lsp", require("kmo.neoconf-schemas.lsp").defaults)
  or {}

if config.dotnet_server ~= "roslyn.nvim" then
  return
end

require("roslyn").setup {
  -- cspell:disable-next-line
  filewatching = "off",
}
