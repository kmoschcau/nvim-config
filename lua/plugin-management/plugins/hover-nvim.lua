--- @type LazyPluginSpec
return {
  "lewis6991/hover.nvim",
  keys = {
    {
      "K",
      function()
        require("hover").hover()
      end,
      desc = "hover.nvim: Trigger for the symbol under the cursor.",
    },
    {
      "gK",
      function()
        require("hover").hover_select()
      end,
      desc = "hover.nvim Trigger selectable for the symbol under the cursor.",
    },
  },
  --- @type Hover.Config
  opts = {
    init = function()
      require "hover.providers.gh"
      require "hover.providers.gh_user"
      require "hover.providers.man"
      require "hover.providers.dictionary"
    end,
    preview_opts = {
      border = "rounded",
    },
    title = true,
  },
}
