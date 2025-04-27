-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "MoaidHathot/dotnet.nvim",
  cmd = "DotnetUI",
  opts = {
    project_selection = {
      path_display = "smart",
    },
  },
}
