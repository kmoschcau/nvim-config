local common = require "plugins.config.lsp.common"
local lspconfig = require "lspconfig"

local simple_servers = {
  "gradle_ls",
  "jedi_language_server",
  "jsonls",
  "lemminx",
  "ruff_lsp",
  "vimls",
}
for _, lsp in ipairs(simple_servers) do
  lspconfig[lsp].setup {
    capabilities = common.capabilities,
    handlers = common.handlers,
  }
end

local server_config_modules = {
  "cssls",
  "ember",
  "glint",
  "html",
  "lua_ls",
  "yamlls",
  "typescript",
}

for _, module_name in ipairs(server_config_modules) do
  require("plugins.config.lsp." .. module_name)
end
