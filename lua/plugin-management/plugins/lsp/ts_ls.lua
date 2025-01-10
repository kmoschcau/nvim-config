local common = require "lsp.common"
local lspconfig = require "lspconfig"

local ts = common.settings.typescript

local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)

local filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
}

lspconfig.ts_ls.setup {
  autostart = config.ecma_server == "ts_ls",
  filetypes = filetypes,
  -- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#initializationoptions
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = require("mason-registry")
          .get_package("vue-language-server")
          :get_install_path() .. "/node_modules/@vue/language-server",
        languages = filetypes,
      },
    },
    preferences = ts.preferences,
  },
  settings = {
    javascript = common.settings.javascript,
    typescript = ts,
  },
}
