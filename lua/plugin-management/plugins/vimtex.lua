-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "lervag/vimtex",
  init = function()
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
  end,
}
