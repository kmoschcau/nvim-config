local disabled_filetypes = {
  "NvimTree",
}

return {
  "nvimtools/none-ls.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local none_ls = require "null-ls"
    local code_actions = none_ls.builtins.code_actions
    local diagnostics = none_ls.builtins.diagnostics
    local formatting = none_ls.builtins.formatting

    local local_config = require "local-config"

    --- Build the extra arguments for checkstyle
    --- @return string[]
    local function build_checkstyle_extra_args()
      local config = local_config.get_config()

      local args = {}

      if config.none_ls.java.checkstyle.file then
        table.insert(args, "$FILENAME")
      else
        table.insert(args, "$ROOT")
      end

      table.insert(args, "-c")
      if config.none_ls.java.checkstyle.config then
        table.insert(args, config.none_ls.java.checkstyle.config)
      else
        table.insert(args, "/google_checks.xml")
      end

      if config.none_ls.java.checkstyle.options then
        for _, arg in
          ipairs(vim.fn.split(config.none_ls.java.checkstyle.options))
        do
          table.insert(args, arg)
        end
      end

      return args
    end

    --- Build the extra arguments for PMD
    --- @return string[]
    local function build_pmd_extra_args()
      local config = local_config.get_config()

      local args = {}

      table.insert(args, "--dir")
      if config.none_ls.java.pmd.dir then
        table.insert(args, config.none_ls.java.pmd.dir)
      else
        table.insert(args, "$ROOT")
      end

      table.insert(args, "--rulesets")
      if config.none_ls.java.pmd.rulesets then
        table.insert(args, config.none_ls.java.pmd.rulesets)
      else
        table.insert(args, "category/java/bestpractices.xml")
      end

      if config.none_ls.java.pmd.cache then
        table.insert(args, "--cache")
        table.insert(args, config.none_ls.java.pmd.cache)
      else
        table.insert(args, "--no-cache")
      end

      return args
    end

    local sources = {
      code_actions.eslint_d,
      code_actions.gitsigns,
      code_actions.shellcheck,

      diagnostics.cfn_lint,
      diagnostics.checkstyle.with {
        args = { "-f", "sarif" },
        extra_args = build_checkstyle_extra_args,
        timeout = -1,
      },
      diagnostics.eslint_d.with {
        extra_filetypes = { "svelte" },
      },
      diagnostics.markdownlint,
      diagnostics.markuplint.with {
        extra_filetypes = { "svelte", "vue" },
      },
      diagnostics.pmd.with {
        args = { "--format", "json" },
        extra_args = build_pmd_extra_args,
        timeout = -1,
      },
      diagnostics.shellcheck,
      diagnostics.selene,
      diagnostics.stylelint.with {
        extra_filetypes = { "svelte", "vue" },
      },
      -- This breaks joining lines with the newer treesitter APIs
      -- diagnostics.todo_comments,
      diagnostics.trail_space.with {
        disabled_filetypes = { "markdown" },
      },
      diagnostics.yamllint,

      formatting.black,
      formatting.csharpier,
      formatting.google_java_format,
      formatting.markdownlint,
      formatting.packer,
      formatting.prettierd.with {
        extra_filetypes = { "svelte" },
      },
      formatting.shellharden,
      formatting.shfmt.with {
        extra_args = { "--indent", "4" },
      },
      formatting.stylelint,
      formatting.stylua,
      formatting.trim_newlines,
      formatting.trim_whitespace,
    }

    if vim.fn.executable "fish" == 1 then
      table.insert(sources, diagnostics.fish)
      table.insert(sources, formatting.fish_indent)
    end

    none_ls.setup {
      border = "rounded",
      should_attach = function(bufnr)
        return not vim.list_contains(
          disabled_filetypes,
          vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        )
      end,
      sources = sources,
    }
  end,
}
