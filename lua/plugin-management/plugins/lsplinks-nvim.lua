-- cspell:words lsplinks

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "icholy/lsplinks.nvim",
  config = function()
    local lsplinks = require "lsplinks"
    lsplinks.setup()
    vim.keymap.set("n", "gx", lsplinks.gx, {
      desc = "LSPLINKS: Open the current filepath or URL at cursor.",
    })
  end,
}
