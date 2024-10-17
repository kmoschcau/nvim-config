-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "chaoren/vim-wordmotion",
  init = function()
    vim.g.wordmotion_mappings = {
      w = "<M-w>",
      b = "<M-b>",
      e = "<M-e>",
      ge = "g<M-e>",
      aw = "g<M-w>",
      iw = "g<M-w>",
    }
  end,
}
