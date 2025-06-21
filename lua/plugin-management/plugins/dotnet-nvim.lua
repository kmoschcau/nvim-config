-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "MoaidHathot/dotnet.nvim",
  cmd = "DotnetUI",
  opts = {
    project_selection = {
      path_display = "smart",
    },
  },
}
