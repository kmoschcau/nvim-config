-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "folke/trouble.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  keys = {
    {
      "<Space>t",
      function()
        require("trouble").toggle { mode = "diagnostics", filter = { buf = 0 } }
      end,
      desc = "Trouble: Toggle the document diagnostics",
    },
    {
      "<Space>T",
      function()
        require("trouble").toggle { mode = "diagnostics" }
      end,
      desc = "Trouble: Toggle the workspace diagnostics",
    },
  },
  --- @type trouble.Config
  opts = {
    auto_preview = false,
  },
}
