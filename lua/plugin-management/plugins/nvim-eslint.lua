-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "esmuellert/nvim-eslint",
  config = function()
    local nvim_eslint = require "nvim-eslint"

    nvim_eslint.setup {
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
        "htmlangular", -- cspell:disable-line
      },
    }
  end,
}
