local lspconfig = require "lspconfig"

---@type vim.lsp.Config
return {
  root_dir = lspconfig.util.root_pattern(
    "typos.toml",
    "_typos.toml",
    ".typos.toml",
    "pyproject.toml"
  ),
}
