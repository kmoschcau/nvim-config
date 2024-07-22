--- @type LazyPluginSpec
return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()

    require("mini.align").setup {
      mappings = {
        start = "<Space>a",
        start_with_preview = "<Space>A",
      },
    }

    local icons = require "mini.icons"
    icons.setup {
      file = {
        ["NuGet.Config"] = {
          glyph = "󰪮",
          hl = "MiniIconsPurple",
        },
      },
    }
    icons.mock_nvim_web_devicons()

    require("mini.surround").setup {
      mappings = {
        add = "ys",
        delete = "ds",
        find = "",
        find_left = "",
        highlight = "",
        replace = "cs",
        update_n_lines = "",
      },
      respect_selection_type = true,
      search_method = "cover_or_next",
    }
    vim.keymap.del("x", "ys")
    vim.keymap.set("x", "S", ':<C-u>lua MiniSurround.add "visual"<CR>', {
      desc = "mini.surround: Surround visual selection.",
      silent = true,
    })
  end,
}
