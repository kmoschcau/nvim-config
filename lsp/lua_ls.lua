--- @type vim.lsp.Config
return {
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
