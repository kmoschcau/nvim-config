local ignored_servers = {
  "html",
  "vtsls",
}

---@param client vim.lsp.Client
local function formatter_filter(client)
  local result = not vim.list_contains(ignored_servers, client.name)

  vim.notify(
    string.format("%s: %s", client.name, result and "formatting" or "ignoring"),
    vim.log.levels.INFO,
    { title = "conform.nvim" }
  )

  return result
end

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        -- cspell:disable
        astro = { "dprint", "prettier" },
        cs = { "csharpier", "trim_newlines" },
        css = { "dprint", "prettier", stop_after_first = true },
        fish = { "fish_indent" },
        handlebars = { "dprint" },
        html = { "dprint", "prettier", stop_after_first = true },
        java = { "google-java-format" },
        javascript = { "dprint", "prettier", stop_after_first = true },
        javascriptreact = { "dprint", "prettier", stop_after_first = true },
        jq = { "jq" },
        json = { "dprint", "prettier", stop_after_first = true },
        json5 = { "prettier" },
        jsonc = { "dprint", "prettier", stop_after_first = true },
        less = { "dprint", "prettier", stop_after_first = true },
        lua = { "stylua" },
        markdown = { "injected", lsp_format = "last" },
        ocaml = { "ocamlformat" },
        query = { "format-queries" },
        razor = { "trim_newlines", lsp_format = "first" },
        sass = { "dprint", "prettier", stop_after_first = true },
        scss = { "dprint", "prettier", stop_after_first = true },
        sh = { "shellharden", "shfmt" },
        svelte = { "dprint", "prettier", stop_after_first = true },
        tex = { "latexindent", "trim_newlines", "trim_whitespace" },
        typescript = { "dprint", "prettier", stop_after_first = true },
        typescriptreact = { "dprint", "prettier", stop_after_first = true },
        vue = { "dprint", "prettier", stop_after_first = true },
        xml = { "xmllint", "trim_newlines", "trim_whitespace" },
        yaml = { "dprint", "prettier", stop_after_first = true },
        ["_"] = { "trim_newlines", "trim_whitespace" },
        -- cspell:enable
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters = {
        dprint = {
          require_cwd = true,
        },
        prettier = {
          cwd = require("conform.util").root_file {
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          },
          require_cwd = true,
        },
        -- cspell:disable-next-line
        shfmt = {
          prepend_args = { "--indent", "4" },
        },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return { filter = formatter_filter, timeout_ms = 500 }
      end,
    }
  end,
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.g.disable_autoformat = true
      else
        vim.b.disable_autoformat = true
      end
    end, {
      bang = true,
      bar = true,
      desc = "Conform: Disable autoformat-on-save.",
    })

    vim.api.nvim_create_user_command("FormatEnable", function(args)
      if args.bang then
        vim.g.disable_autoformat = false
      else
        vim.b.disable_autoformat = false
      end
    end, {
      bang = true,
      bar = true,
      desc = "Conform: Enable autoformat-on-save.",
    })

    vim.keymap.set({ "n", "x" }, "<Space>f", function()
      require("conform").format {
        async = true,
        filter = formatter_filter,
      }
    end, { desc = "Conform: Format the current buffer or selection." })
    vim.keymap.set({ "n", "x" }, "<Space>lf", function()
      require("conform").format {
        async = true,
        lsp_format = "prefer",
      }
    end, {
      desc = "Conform: Format the current buffer or selection with LSP.",
    })
  end,
}
