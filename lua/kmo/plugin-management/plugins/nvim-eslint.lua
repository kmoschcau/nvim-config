local notify_title = "nvim-eslint"

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
      handlers = {
        ["eslint/confirmESLintExecution"] = function(_, result)
          if not result then
            return
          end

          return 4 -- approved
        end,
        ["eslint/noConfig"] = function()
          vim.notify(
            "Unable to find ESLint configuration file.",
            vim.log.levels.ERROR,
            { title = notify_title }
          )

          return {}
        end,
        ["eslint/noLibrary"] = function()
          vim.notify(
            "Unable to find ESLint library.",
            vim.log.levels.ERROR,
            { title = notify_title }
          )

          return {}
        end,
        ["eslint/openDoc"] = function(_, result)
          if result then
            local _, error = vim.ui.open(result.url)

            if error then
              vim.notify(
                string.format(
                  "Could not open the documentation.\nCause:\n%s",
                  error
                ),
                vim.log.levels.ERROR,
                { title = notify_title }
              )
            end
          end

          return {}
        end,
        ["eslint/probeFailed"] = function()
          vim.notify(
            "ESLint probe failed.",
            vim.log.levels.ERROR,
            { title = notify_title }
          )

          return {}
        end,
      },
      settings = {
        nodePath = vim.NIL,
      },
    }
  end,
}
