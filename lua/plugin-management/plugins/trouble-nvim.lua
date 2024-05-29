--- @type LazyPluginSpec
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<Space>t",
      function()
        require("trouble").toggle "document_diagnostics"
      end,
      desc = "Trouble: Toggle the document diagnostics",
    },
    {
      "<Space>T",
      function()
        require("trouble").toggle "workspace_diagnostics"
      end,
      desc = "Trouble: Toggle the workspace diagnostics",
    },
  },
  --- @type TroubleOptions
  opts = {
    padding = false,
    signs = {
      error = require("symbols").diagnostics.severities.error,
      warning = require("symbols").diagnostics.severities.warn,
      information = require("symbols").diagnostics.severities.info,
      hint = require("symbols").diagnostics.severities.hint,
      other = require("symbols").diagnostics.severities.info,
    },
  },
}
