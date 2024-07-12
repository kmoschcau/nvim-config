require("lspconfig").omnisharp.setup {
  cmd = { require("system-compat").append_win_ext "omnisharp" },
  -- Configuration is done in `~/.omnisharp/`.
}
