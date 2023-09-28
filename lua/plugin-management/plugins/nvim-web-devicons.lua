return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    default = true,
    strict = true,
    override_by_filename = {
      ["NuGet"] = {
        icon = "󰪮",
        color = "#443ad1",
        name = "NuGetConfig",
      },
    },
    override_by_extension = {
      csproj = {
        icon = "󰪮",
        color = "#443ad1",
        name = "DotNet",
      },
      nswag = {
        icon = "",
        color = "#cbcb41",
        name = "Nswag",
      },
      ttf = {
        icon = "",
        name = "TrueType",
      },
      xaml = {
        icon = "󰙳",
        color = "#443ad1",
        name = "Xaml",
      },
    },
  },
}
