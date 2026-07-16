---@type vim.lsp.Config
return {
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
