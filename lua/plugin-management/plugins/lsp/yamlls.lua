local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.yamlls.setup {
  cmd = { compat.append_win_ext "yaml-language-server", "--stdio" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  -- https://github.com/redhat-developer/yaml-language-server?tab=readme-ov-file#language-server-settings
  settings = {
    yaml = {
      schemastore = {
        enable = true,
      },
      customTags = {
        "!And",
        "!Base64",
        "!Cidr",
        "!Equals",
        "!FindInMap sequence",
        "!GetAZs",
        "!GetAtt",
        "!If",
        "!ImportValue",
        "!Join sequence",
        "!Not",
        "!Or",
        "!Ref Scalar",
        "!Ref",
        "!Select sequence",
        "!Split",
        "!Sub sequence",
        "!fn",
      },
    },
  },
}
