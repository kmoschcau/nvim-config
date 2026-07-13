---@type vim.lsp.Config
return {
  -- HACK: This is only needed for as long as the following issue is not
  -- resolved: https://github.com/mason-org/mason-registry/issues/15934
  cmd = {
    "vue-language-server",
    "--stdio",
    "--tsdk="
      .. vim.fn.expand "$MASON/packages/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib",
  },

  -- There seems to be no official documentation of this. Just check in
  -- VSCodium.
  settings = {
    vue = {
      inlayHints = {
        destructuredProps = true,
        inlineHandlerLeading = true,
        missingProps = true,
        optionsWrapper = true,
        vBindShorthand = true,
      },
    },
  },
}
