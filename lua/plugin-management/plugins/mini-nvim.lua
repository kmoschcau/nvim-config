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

    local starter = require "mini.starter"
    starter.setup {
      evaluate_single = true,
      items = {
        starter.sections.recent_files(nil, true),
        starter.sections.recent_files(),
        starter.sections.builtin_actions(),
        { name = "Lazy", action = "Lazy", section = "Updates" },
        { name = "Mason", action = "Mason", section = "Updates" },
      },
    }

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
    vim.keymap.set("i", "<C-g>s", "<C-o>vS", {
      desc = "mini.surround: Surround inline.",
      remap = true,
      silent = true,
    })
    vim.keymap.set("i", "<C-g>S", "<C-o>VS", {
      desc = "mini.surround: Surround with lines.",
      remap = true,
      silent = true,
    })
  end,
}
