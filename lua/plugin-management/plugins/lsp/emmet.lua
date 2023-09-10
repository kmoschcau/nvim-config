local common = require "lsp.common"
local lspconfig = require "lspconfig"

lspconfig.emmet_language_server.setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
  filetypes = {
    "astro",
    "css",
    "eruby",
    "html",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "razor",
    "sass",
    "scss",
    "svelte",
    "typescriptreact",
    "vue",
  },
  init_options = {
    preferences = {
      output = {
        selfClosingStyle = "xhtml",
      },
    },
  },
}
