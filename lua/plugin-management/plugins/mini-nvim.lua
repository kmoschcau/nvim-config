-- cspell:words devicons termbg splitjoin treesj

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.ai").setup {
      mappings = {
        -- These would otherwise override neovim defaults and I don't use them.
        around_next = "",
        inside_next = "",
        around_last = "",
        inside_last = "",

        -- I don't need these and they just pollute the global mappings.
        goto_left = "",
        goto_right = "",
      },
    }

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

    local misc = require "mini.misc"
    if not vim.g.neovide then
      misc.setup_termbg_sync()
    end

    require("mini.splitjoin").setup {
      -- See treesj config.
      mappings = {
        join = "",
        split = "",
        toggle = "",
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
