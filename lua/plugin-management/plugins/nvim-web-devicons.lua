local dotnet_icon = "󰪮"
local dotnet_color = "#512bd4"

local font_icon = ""
local font_color = "#2f2f2f"

return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    default = true,
    strict = true,
    override_by_filename = {
      ["NuGet.Config"] = {
        icon = dotnet_icon,
        color = "#004880",
        name = "NuGetConfig",
      },
    },
    override_by_extension = {
      azcli = {
        icon = "",
        color = "#0078d4",
        name = "AzureCli",
      },
      cshtml = {
        icon = "󱦗",
        color = dotnet_color,
        name = "RazorPage",
      },
      csproj = {
        icon = dotnet_icon,
        color = dotnet_color,
        name = "CSharpProject",
      },
      eot = {
        icon = font_icon,
        color = font_color,
        name = "EmbeddedOpenTypeFont",
      },
      nswag = {
        icon = "",
        color = "#85ea2d",
        name = "Nswag",
      },
      razor = {
        icon = "󱦘",
        color = dotnet_color,
        name = "RazorComponent",
      },
      ttf = {
        icon = font_icon,
        color = font_color,
        name = "TrueTypeFont",
      },
      woff = {
        icon = font_icon,
        color = font_color,
        name = "WebOpenFontFormat",
      },
      woff2 = {
        icon = font_icon,
        color = font_color,
        name = "WebOpenFontFormat",
      },
      xaml = {
        icon = "󰙳",
        color = dotnet_color,
        name = "Xaml",
      },
    },
  },
}
