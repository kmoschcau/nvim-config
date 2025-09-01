---@type vim.lsp.Config
return {
  filetypes = {
    "html", -- needs @html-eslint/parser
    "json", -- needs @eslint/json
    "json5", -- needs @eslint/json
    "jsonc", -- needs @eslint/json
    -- default ones below
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte",
    "astro",
    "htmlangular",
  },
  -- https://github.com/Microsoft/vscode-eslint#settings-options
  settings = {
    eslint = {
      format = {
        enable = false,
      },
      probe = {
        "svelte",
        -- default ones below
        "astro",
        "civet",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
        "mdx",
        "vue",
        "markdown",
        "json",
        "json5",
        "jsonc",
      },
    },
  },
}
