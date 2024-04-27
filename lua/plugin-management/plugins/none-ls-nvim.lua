--- @type LazyPluginSpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "folke/neoconf.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local none_ls = require "null-ls"
    local code_actions = none_ls.builtins.code_actions
    local diagnostics = none_ls.builtins.diagnostics
    local formatting = none_ls.builtins.formatting

    local config = require("neoconf").get(
      "none_ls",
      require("neoconf-schemas.none-ls").defaults
    )

    --- Build the extra arguments for checkstyle
    --- @return string[]
    local function build_checkstyle_extra_args()
      local cs_config = config.java.checkstyle

      local args = {}

      if cs_config.file then
        table.insert(args, "$FILENAME")
      else
        table.insert(args, "$ROOT")
      end

      table.insert(args, "-c")
      table.insert(args, cs_config.config)

      if cs_config.options then
        for _, arg in ipairs(vim.fn.split(cs_config.options)) do
          table.insert(args, arg)
        end
      end

      return args
    end

    --- Build the extra arguments for PMD
    --- @return string[]
    local function build_pmd_extra_args()
      local pmd_config = config.java.pmd

      local args = {}

      table.insert(args, "--dir")
      table.insert(args, pmd_config.dir)

      table.insert(args, "--rulesets")
      table.insert(args, pmd_config.rulesets)

      if pmd_config.cache then
        table.insert(args, "--cache")
        table.insert(args, pmd_config.cache)
      else
        table.insert(args, "--no-cache")
      end

      return args
    end

    local sources = {
      code_actions.gitsigns,
      code_actions.proselint,

      diagnostics.actionlint,
      diagnostics.cfn_lint,
      diagnostics.checkstyle.with {
        args = { "-f", "sarif" },
        extra_args = build_checkstyle_extra_args,
        timeout = -1,
      },
      diagnostics.ktlint,
      diagnostics.markdownlint,
      diagnostics.markuplint.with {
        extra_filetypes = { "svelte", "vue" },
      },
      diagnostics.pmd.with {
        args = { "--format", "json" },
        extra_args = build_pmd_extra_args,
        timeout = -1,
      },
      diagnostics.proselint,
      diagnostics.selene,
      diagnostics.terraform_validate,
      -- This breaks joining lines with the newer treesitter APIs
      -- diagnostics.todo_comments,
      diagnostics.trail_space.with {
        disabled_filetypes = { "markdown" },
      },
      diagnostics.trivy,
      diagnostics.yamllint,

      formatting.black,
      formatting.csharpier,
      formatting.google_java_format,
      formatting.ktlint,
      formatting.markdownlint,
      formatting.packer,
      formatting.prettierd.with {
        disabled_filetypes = { "markdown" },
      },
      formatting.shellharden,
      formatting.shfmt.with {
        extra_args = { "--indent", "4" },
      },
      formatting.stylua,
      formatting.terraform_fmt,
    }

    if vim.fn.executable "fish" == 1 then
      table.insert(sources, diagnostics.fish)
      table.insert(sources, formatting.fish_indent)
    end

    none_ls.setup {
      border = "rounded",
      sources = sources,
    }
  end,
}
