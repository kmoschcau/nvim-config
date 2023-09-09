local common = require "lsp.common"
local compat = require "system-compat"
local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  cmd = { compat.append_win_ext "lua-language-server" },
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    Lua = {
      codelens = {
        enable = true,
      },
      completion = {
        callSnippet = "Both",
      },
      format = {
        enable = false,
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
