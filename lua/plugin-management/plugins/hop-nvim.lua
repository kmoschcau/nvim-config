-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "smoka7/hop.nvim",
  opts = {
    uppercase_labels = true,
    multi_windows = true,
  },
  init = function()
    local hop = require "hop"
    local hint = require "hop.hint"

    vim.keymap.set({ "n" }, "s", function()
      ---@diagnostic disable-next-line: missing-fields
      hop.hint_camel_case {}
    end, {
      desc = "Hop: Jump to a camelCase position in view.",
    })

    vim.keymap.set({ "n" }, "f", function()
      ---@diagnostic disable-next-line: missing-fields
      hop.hint_char1 {
        direction = hint.HintDirection.AFTER_CURSOR,
        current_line_only = true,
      }
    end, {
      desc = "Hop: Jump to character to the right.",
    })

    vim.keymap.set({ "n" }, "F", function()
      ---@diagnostic disable-next-line: missing-fields
      hop.hint_char1 {
        direction = hint.HintDirection.BEFORE_CURSOR,
        current_line_only = true,
      }
    end, {
      desc = "Hop: Jump to character to the left.",
    })

    vim.keymap.set({ "n" }, "t", function()
      ---@diagnostic disable-next-line: missing-fields
      hop.hint_char1 {
        direction = hint.HintDirection.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1,
      }
    end, {
      desc = "Hop: Jump till before character to the right.",
    })

    vim.keymap.set({ "n" }, "T", function()
      ---@diagnostic disable-next-line: missing-fields
      hop.hint_char1 {
        direction = hint.HintDirection.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1,
      }
    end, {
      desc = "Hop: Jump till after character to the left.",
    })
  end,
}
