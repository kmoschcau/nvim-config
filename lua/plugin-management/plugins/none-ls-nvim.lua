-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "folke/neoconf.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local none_ls = require "null-ls"
    local diagnostics = none_ls.builtins.diagnostics

    local config = require("neoconf").get(
      "none_ls",
      require("neoconf-schemas.none-ls").defaults
    )

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
      diagnostics.pmd.with {
        args = { "--format", "json" },
        extra_args = build_pmd_extra_args,
        timeout = -1,
      },
    }

    none_ls.setup {
      border = "rounded",
      sources = sources,
    }
  end,
}
