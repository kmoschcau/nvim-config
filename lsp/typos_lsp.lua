local lspconfig = require "lspconfig"

return {
  root_dir = lspconfig.util.root_pattern(
    "typos.toml",
    "_typos.toml",
    ".typos.toml",
    "pyproject.toml"
  ),
  -- HACK: Has to be explicitly set to false, otherwise config files don't work.
  single_file_support = false,
}
