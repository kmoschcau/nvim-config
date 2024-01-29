--- @type LazyPluginSpec
return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    default = true,
    strict = true,
    override_by_filename = {
      ["NuGet.Config"] = {
        icon = "󰪮",
        color = "#004880",
        name = "NuGetConfig",
      },
    },
  },
}
