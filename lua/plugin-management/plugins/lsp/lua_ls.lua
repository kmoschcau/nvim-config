local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  cmd = { compat.append_win_ext "lua-language-server" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  -- https://luals.github.io/wiki/settings/
  settings = {
    Lua = {
      codelens = {
        enable = true,
      },
      completion = {
        callSnippet = "Both",
        keywordSnippet = "Both",
      },
      format = {
        enable = false,
      },
      hint = {
        enable = true,
        setTypes = true,
      },
      runtime = {
        version = "LuaJIT",
      },
    },
  },
}
