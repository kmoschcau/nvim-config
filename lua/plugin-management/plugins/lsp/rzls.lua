require("rzls").setup {
  capabilities = require("lsp.common").capabilities,
  on_attach = require "lsp.attach",
}
