-- cspell:words gnormal gvisual

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "monaqa/dial.nvim",
  config = function()
    local augend = require "dial.augend"

    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,

        augend.date.new {
          pattern = "%Y/%m/%d",
          default_kind = "day",
          clamp = true,
          end_sensitive = true,
        },
        augend.date.new {
          pattern = "%Y-%m-%d",
          default_kind = "day",
          clamp = true,
          end_sensitive = true,
        },
        augend.date.new {
          pattern = "%m/%d",
          default_kind = "day",
          only_valid = true,
          clamp = true,
          end_sensitive = true,
        },
        augend.date.new {
          pattern = "%H:%M",
          default_kind = "min",
          only_valid = true,
        },
        augend.date.new {
          pattern = "%d.%m.%Y",
          default_kind = "day",
          clamp = true,
          end_sensitive = true,
        },

        augend.constant.alias.bool,

        augend.hexcolor.new {
          case = "lower",
        },

        augend.semver.alias.semver,

        augend.misc.alias.markdown_header,
      },
    }

    local map = require "dial.map"

    vim.keymap.set("n", "<C-a>", function()
      map.manipulate("increment", "normal")
    end, { desc = "Dial: increment" })

    vim.keymap.set("n", "<C-x>", function()
      map.manipulate("decrement", "normal")
    end, { desc = "Dial: decrement" })

    vim.keymap.set("n", "g<C-a>", function()
      map.manipulate("increment", "gnormal")
    end, { desc = "Dial: Start a new dial additive increment, use with ." })

    vim.keymap.set("n", "g<C-x>", function()
      map.manipulate("decrement", "gnormal")
    end, { desc = "Dial: Start a new dial additive decrement, use with ." })

    vim.keymap.set("x", "<C-a>", function()
      map.manipulate("increment", "visual")
    end, { desc = "Dial: increment" })

    vim.keymap.set("x", "<C-x>", function()
      map.manipulate("decrement", "visual")
    end, { desc = "Dial: decrement" })

    vim.keymap.set("x", "g<C-a>", function()
      map.manipulate("increment", "gvisual")
    end, { desc = "Dial: Additive increment" })

    vim.keymap.set("x", "g<C-x>", function()
      map.manipulate("decrement", "gvisual")
    end, { desc = "Dial: Additive decrement" })
  end,
}
