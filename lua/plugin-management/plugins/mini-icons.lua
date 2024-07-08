--- @type LazyPluginSpec
return {
  "echasnovski/mini.icons",
  opts = {
    file = {
      ["NuGet.Config"] = {
        glyph = "󰪮",
        hl = "MiniIconsPurple",
      },
    },
  },
  init = function()
    require("mini.icons").mock_nvim_web_devicons()
  end,
}
