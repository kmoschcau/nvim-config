require("lspconfig").tailwindcss.setup {
  cmd = {
    require("system-compat").append_win_ext "tailwindcss-language-server",
    "--stdio",
  },
  -- https://github.com/tailwindlabs/tailwindcss-intellisense?tab=readme-ov-file#extension-settings
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
    },
  },
}
