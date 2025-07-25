-- cspell:words autosnippets luasnip prio virt_text

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "L3MON4D3/LuaSnip",
  dependencies = {
    -- cspell:disable
    "rafamadriz/friendly-snippets",
    -- cspell:enable
  },
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

    local function make_ext_opts(sign)
      return {
        active = {
          hl_group = "LuaSnipActive",
          virt_text = { { sign, "LuaSnipVirtualActive" } },
        },
        passive = {
          hl_group = "LuaSnipPassive",
          virt_text = { { sign, "LuaSnipVirtualPassive" } },
        },
        visited = {
          hl_group = "LuaSnipVisited",
          virt_text = { { sign, "LuaSnipVirtualVisited" } },
        },
        unvisited = {
          hl_group = "LuaSnipUnvisited",
          virt_text = { { sign, "LuaSnipVirtualUnvisited" } },
        },
      }
    end

    ls.setup {
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = make_ext_opts(
          require("symbols").snippet.choice_virtual_text
        ),
        [types.insertNode] = make_ext_opts(
          require("symbols").snippet.insert_virtual_text
        ),
      },
      ext_prio_increase = 2,
      ft_func = function()
        local ts_fts = ext_ft.from_cursor_pos()
        return #ts_fts > 0 and ts_fts or ext_ft.from_filetype()
      end,
      load_ft_func = ext_ft.extend_load_ft {
        cs = { "comment" },
        html = { "css", "javascript" },
        vue = { "css", "javascript", "sass", "scss", "typescript" },
      },
    }

    vim.keymap.set({ "n", "i", "s" }, "<M-s>", function()
      if ls.expandable() then
        ls.expand()
      elseif vim.snippet.active() then
        vim.snippet.jump(1)
      end
    end, {
      desc = "LuaSnip: Expand the a snippet.",
    })

    vim.keymap.set({ "n", "i", "s" }, "<M-l>", function()
      if ls.jumpable(1) then
        ls.jump(1)
      elseif vim.snippet.active() then
        vim.snippet.jump(1)
      end
    end, {
      desc = "LuaSnip: Jump to the next placeholder.",
    })

    vim.keymap.set({ "n", "i", "s" }, "<M-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      elseif vim.snippet.active() then
        vim.snippet.jump(-1)
      end
    end, {
      desc = "LuaSnip: Jump to the previous placeholder.",
    })

    vim.keymap.set({ "n", "i", "s" }, "<M-k>", function()
      ls.change_choice(-1)
    end, {
      desc = "LuaSnip: Change to the previous choice node choice.",
    })

    vim.keymap.set({ "n", "i", "s" }, "<M-j>", function()
      ls.change_choice(1)
    end, {
      desc = "LuaSnip: Change to the next choice node choice.",
    })

    vim.keymap.set({ "n" }, "<Esc>", function()
      ls.unlink_current()
    end, {
      desc = "LuaSnip: Unlink the current snippet.",
    })
  end,
}
