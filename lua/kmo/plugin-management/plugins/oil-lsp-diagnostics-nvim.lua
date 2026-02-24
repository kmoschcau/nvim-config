-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "JezerM/oil-lsp-diagnostics.nvim",
  dependencies = {
    -- cspell:disable
    "stevearc/oil.nvim",
    -- cspell:enable
  },
  config = true,
}
