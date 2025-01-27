-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()

    for _, ft_path in
      ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true))
    do
      loadfile(ft_path)()
    end

    local ls = require "luasnip"
    local ext_ft = require "luasnip.extras.filetype_functions"
    local types = require "luasnip.util.types"

    local ext_opts = {
      active = {
        hl_group = "LuaSnipActive",
        virt_text = { { "…", "LuaSnipVirtualActive" } },
      },
      passive = {
        hl_group = "LuaSnipPassive",
        virt_text = { { "…", "LuaSnipVirtualPassive" } },
      },
      visited = {
        hl_group = "LuaSnipVisited",
        virt_text = { { "…", "LuaSnipVirtualVisited" } },
      },
      unvisited = {
        hl_group = "LuaSnipUnvisited",
        virt_text = { { "…", "LuaSnipVirtualUnvisited" } },
      },
    }

    ls.setup {
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = ext_opts,
        [types.insertNode] = ext_opts,
      },
      ft_func = function()
        local ts_fts = ext_ft.from_cursor_pos()
        return #ts_fts > 0 and ts_fts or ext_ft.from_filetype()
      end,
      load_ft_func = ext_ft.extend_load_ft {
        html = { "css", "javascript" },
        cs = { "comment" },
      },
    }

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, {
      desc = "LuaSnip: Expand or jump to next placeholder",
    })

    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, {
      desc = "LuaSnip: Expand or jump to previous placeholder",
    })
  end,
}
