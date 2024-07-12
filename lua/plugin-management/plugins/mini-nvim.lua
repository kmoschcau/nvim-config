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
    require("mini.icons").mock_nvim_web_devicons()
  end,
}
