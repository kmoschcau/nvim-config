-- cspell:words rzls

local prettier = "prettier"

local ignored_servers = {
  "html",
  "rzls",
}

---@param client vim.lsp.Client
local function formatter_filter(client)
  return not vim.list_contains(ignored_servers, client.name)
end

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "stevearc/conform.nvim",
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      -- cspell:disable
      astro = { prettier },
      cs = { "csharpier", "trim_newlines" },
      css = { prettier },
      fish = { "fish_indent" },
      html = { prettier },
      java = { "google-java-format" },
      javascript = { prettier },
      javascriptreact = { prettier },
      jq = { "jq" },
      json = { prettier },
      jsonc = { prettier },
      less = { prettier },
      lua = { "stylua" },
      markdown = { "injected", "markdownlint" },
      ocaml = { "ocamlformat" },
      query = { "format-queries" },
      razor = { "trim_newlines", lsp_format = "first" },
      sass = { prettier },
      scss = { prettier },
      sh = { "shellharden", "shfmt" },
      svelte = { prettier },
      tex = { "latexindent", "trim_newlines", "trim_whitespace" },
      typescript = { prettier },
      typescriptreact = { prettier },
      vue = { prettier },
      xml = { "xmllint", "trim_newlines", "trim_whitespace" },
      yaml = { prettier },
      ["_"] = { "trim_newlines", "trim_whitespace" },
      -- cspell:enable
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters = {
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
  },
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
