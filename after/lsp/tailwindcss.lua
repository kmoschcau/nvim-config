local has_neoconf, neoconf = pcall(require, "neoconf")

---@type vim.lsp.Config
return {
  -- https://github.com/tailwindlabs/tailwindcss-intellisense?tab=readme-ov-file#extension-settings
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
      rootFontSize = has_neoconf
          and neoconf.get "vscode.tailwindCSS.rootFontSize"
        or nil,
    },
  },
}
