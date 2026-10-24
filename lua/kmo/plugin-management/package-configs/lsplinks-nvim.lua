-- cspell:words lsplinks

local lsplinks = require "lsplinks"
lsplinks.setup()
vim.keymap.set("n", "gx", lsplinks.gx, {
  desc = "LSPLINKS: Open the current filepath or URL at cursor.",
})
