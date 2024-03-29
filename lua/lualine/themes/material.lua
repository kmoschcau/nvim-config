-- This file has to be here instead of the plugin dir, to be loaded by lualine.

-- This replaces the default statusline highlight with the strong framing
-- highlight. This is meant to be used to remove the differing, one character
-- highlight on the right side of the statusline for windows on the bottom when
-- lualine is in use.
vim.api.nvim_set_hl(0, "StatusLine", {
  link = "Material_VimStrongFramingWithFg",
})

return {
  normal = {
    a = "Material_VimStatusLine",
    b = "Material_VimLightFramingStrongFg",
    c = "Material_Lualine3",
  },
  insert = {
    a = "Material_LualineInsert",
  },
  replace = {
    a = "Material_LualineReplace",
  },
  visual = {
    a = "Material_VimVisual",
  },
  inactive = {
    a = "Material_Lualine1",
  },
}
