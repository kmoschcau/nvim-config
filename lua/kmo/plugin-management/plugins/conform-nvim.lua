local ignored_servers = {
  "html",
  "vtsls",
}

---@param client vim.lsp.Client
local function lsp_formatter_filter(client)
  return not vim.list_contains(ignored_servers, client.name)
end

-- selene: allow(mixed_table)
local web_formatters_config =
  -- cspell:disable-next-line
  { "oxfmt", "dprint", "prettier", stop_after_first = true }

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
        css = web_formatters_config,
        fish = { "fish_indent" },
        handlebars = { "oxfmt", "dprint", stop_after_first = true },
        html = web_formatters_config,
        java = { "google-java-format" },
        javascript = web_formatters_config,
        javascriptreact = web_formatters_config,
        jq = { "jq" },
        json = web_formatters_config,
        json5 = { "oxfmt", "prettier", stop_after_first = true },
        jsonc = web_formatters_config,
        less = web_formatters_config,
        lua = { "stylua" },
        markdown = { "oxfmt", "injected", lsp_format = "last" },
        ocaml = { "ocamlformat" },
        query = { "format-queries" },
        razor = { "trim_newlines", lsp_format = "first" },
        sass = web_formatters_config,
        scss = web_formatters_config,
        sh = { "shellharden", "shfmt" },
        svelte = { "dprint", "prettier", stop_after_first = true },
        tex = { "latexindent", "trim_newlines", "trim_whitespace" },
        toml = { "oxfmt" },
        typescript = web_formatters_config,
        typescriptreact = web_formatters_config,
        vue = web_formatters_config,
        xml = { "xmllint", "trim_newlines", "trim_whitespace" },
        yaml = web_formatters_config,
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
          require_cwd = true,
        },
        -- cspell:disable-next-line
        oxfmt = {
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

        return { filter = lsp_formatter_filter, timeout_ms = 500 }
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
        filter = lsp_formatter_filter,
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
