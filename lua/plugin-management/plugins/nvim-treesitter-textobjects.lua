-- cspell:words textobjects textobject

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  config = function()
    require("nvim-treesitter-textobjects").setup {
      move = {
        set_jumps = true,
      },
      select = {
        lookahead = true,
      },
    }

    local move = require "nvim-treesitter-textobjects.move"

    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      move.goto_next_start "@function.outer"
    end, { desc = "treesitter-textobjects: Next function start" })

    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      move.goto_previous_start "@function.outer"
    end, { desc = "treesitter-textobjects: Previous function start" })

    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      move.goto_next_end "@function.outer"
    end, { desc = "treesitter-textobjects: Next function end" })

    vim.keymap.set({ "n", "x", "o" }, "[M", function()
      move.goto_previous_end "@function.outer"
    end, { desc = "treesitter-textobjects: Previous function end" })

    vim.keymap.set({ "n", "x", "o" }, "]]", function()
      move.goto_next_start "@class.outer"
    end, { desc = "treesitter-textobjects: Next class start" })

    vim.keymap.set({ "n", "x", "o" }, "[[", function()
      move.goto_previous_start "@class.outer"
    end, { desc = "treesitter-textobjects: Previous class start" })

    vim.keymap.set({ "n", "x", "o" }, "][", function()
      move.goto_next_end "@class.outer"
    end, { desc = "treesitter-textobjects: Next class end" })

    vim.keymap.set({ "n", "x", "o" }, "[]", function()
      move.goto_previous_end "@class.outer"
    end, { desc = "treesitter-textobjects: Previous class end" })

    local select = require "nvim-treesitter-textobjects.select"

    vim.keymap.set({ "x", "o" }, "am", function()
      select.select_textobject "@function.outer"
    end, { desc = "treesitter-textobjects: Select outer function" })

    vim.keymap.set({ "x", "o" }, "im", function()
      select.select_textobject "@function.inner"
    end, { desc = "treesitter-textobjects: Select inner function" })

    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject "@class.outer"
    end, { desc = "treesitter-textobjects: Select outer class" })

    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject "@class.inner"
    end, { desc = "treesitter-textobjects: Select inner class" })

    local swap = require "nvim-treesitter-textobjects.swap"

    vim.keymap.set("n", "<Space>]p", function()
      swap.swap_next "@parameter.inner"
    end, { desc = "treesitter-textobjects: Swap with next parameter" })

    vim.keymap.set("n", "<Space>[p", function()
      swap.swap_previous "@parameter.inner"
    end, { desc = "treesitter-textobjects: Swap with previous parameter" })
  end,
}
