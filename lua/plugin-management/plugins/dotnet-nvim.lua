-- selene: allow(mixed_table)
---@module "lazy"
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
