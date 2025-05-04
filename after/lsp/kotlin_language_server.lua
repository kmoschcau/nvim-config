---@type vim.lsp.Config
return {
  -- https://github.com/fwcd/vscode-kotlin/blob/main/package.json
  settings = {
    kotlin = {
      inlayHints = {
        chainedHints = true,
        parameterHints = true,
        typeHints = true,
      },
    },
  },
}
