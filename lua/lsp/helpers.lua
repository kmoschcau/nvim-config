local M = {}

---Get the roslyn command for the roslyn language server.
---@return string[]
function M.get_roslyn_cmd()
  local mason_registry = require "mason-registry"

  ---@type string[]
  local cmd = {}

  local roslyn_package = mason_registry.get_package "roslyn"
  if roslyn_package:is_installed() then
    vim.list_extend(cmd, {
      "dotnet",
      vim.fs.joinpath(
        roslyn_package:get_install_path(),
        "libexec",
        "Microsoft.CodeAnalysis.LanguageServer.dll"
      ),
      "--stdio",
      "--logLevel=Information",
      "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
    })

    local rzls_package = mason_registry.get_package "rzls"
    if rzls_package:is_installed() then
      local rzls_path =
        vim.fs.joinpath(rzls_package:get_install_path(), "libexec")
      table.insert(
        cmd,
        "--razorSourceGenerator="
          .. vim.fs.joinpath(
            rzls_path,
            "Microsoft.CodeAnalysis.Razor.Compiler.dll"
          )
      )
      table.insert(
        cmd,
        "--razorDesignTimePath="
          .. vim.fs.joinpath(
            rzls_path,
            "Targets",
            "Microsoft.NET.Sdk.Razor.DesignTime.targets"
          )
      )
    end
  end

  return cmd
end

return M
