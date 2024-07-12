require("lspconfig").lua_ls.setup {
  cmd = { require("system-compat").append_win_ext "lua-language-server" },
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
