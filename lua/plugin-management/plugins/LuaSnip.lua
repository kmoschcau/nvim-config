--- @type LazyPluginSpec
return {
  "L3MON4D3/LuaSnip",
  dependencies = "rafamadriz/friendly-snippets",
  build = "make install_jsregexp",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()

    for _, ft_path in
      ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true))
    do
      loadfile(ft_path)()
    end

    local ls = require "luasnip"

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, {
      silent = true,
      desc = "LuaSnip: Expand or jump to next placeholder",
    })

    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, {
      silent = true,
      desc = "LuaSnip: Expand or jump to next placeholder",
    })
  end,
}
