-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "folke/neoconf.nvim",
  config = function()
    require("neoconf").setup {}

    require("neoconf.plugins").register {
      name = "lsp",
      on_schema = function(schema)
        local lsp = require "neoconf-schemas.lsp"
        schema:import("lsp", lsp.defaults)
        schema:set("lsp.ecma_server", lsp.schema.ecma_server)
      end,
    }

    require("neoconf.plugins").register {
      name = "none_ls",
      on_schema = function(schema)
        local none_ls = require "neoconf-schemas.none-ls"
        schema:import("none_ls", none_ls.defaults)
        schema:set("none_ls.java", none_ls.schema)
      end,
    }
  end,
}
