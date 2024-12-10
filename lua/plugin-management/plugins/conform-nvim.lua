local ignored_servers = {
  "html",
}

--- @param client vim.lsp.Client
local function formatter_filter(client)
  return not vim.list_contains(ignored_servers, client.name)
end

-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  --- @type conform.setupOpts
  opts = {
    formatters_by_ft = {
      cs = { "csharpier" },
      css = { "prettierd" },
      fish = { "fish_indent" },
      html = { "prettierd" },
      java = { "google-java-format" },
      javascript = { "prettierd" },
      jq = { "jq" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      latex = { "latexindent" },
      less = { "prettierd" },
      lua = { "stylua" },
      markdown = { "injected", "markdownlint" },
      ocaml = { "ocamlformat" },
      query = { "format-queries" },
      scss = { "prettierd" },
      sh = { "shellharden", "shfmt" },
      svelte = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      vue = { "prettierd" },
      xml = { "xmllint" },
      yaml = { "prettierd" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters = {
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
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line =
          vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format {
        async = true,
        filter = formatter_filter,
        range = range,
      }
    end, { bar = true, range = true })

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

    vim.keymap.set("n", "<Space>f", "<Cmd>Format<CR>", {
      desc = "Conform: Format the current buffer.",
      silent = true,
    })
    vim.keymap.set("x", "<Space>f", "<Cmd>'<,'>Format<CR>", {
      desc = "Conform: Format the current selection.",
      silent = true,
    })
    vim.keymap.set("n", "]Fc", "<Cmd>FormatDisable<CR>", {
      desc = "Conform: Disable autoformat-on-save.",
      silent = true,
    })
    vim.keymap.set("n", "[Fc", "<Cmd>FormatEnable<CR>", {
      desc = "Conform: Enable autoformat-on-save.",
      silent = true,
    })
  end,
}
