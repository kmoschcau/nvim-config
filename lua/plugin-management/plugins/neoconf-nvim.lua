-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "folke/neoconf.nvim",
  config = function()
    require("neoconf").setup {}

    require("neoconf.plugins").register {
      name = "lsp",
      on_schema = function(schema)
        local lsp = require "neoconf-schemas.lsp"
        schema:import("lsp", lsp.defaults)
        schema:set("lsp.dotnet_server", lsp.schema.dotnet_server)
        schema:set("lsp.ecma_server", lsp.schema.ecma_server)
      end,
    }

    require("neoconf.plugins").register {
      name = "linters",
      on_schema = function(schema)
        local linters = require "neoconf-schemas.linters"
        schema:import("linters", linters.defaults)
        schema:set("linters.java", linters.schema)
      end,
    }
  end,
}
