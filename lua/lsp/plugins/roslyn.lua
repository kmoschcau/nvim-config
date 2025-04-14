local mason_registry = require "mason-registry"

--- @type string[]
local args = {
  "--stdio",
  "--logLevel=Information",
  "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
}

local rzls_package = mason_registry.get_package "rzls"
if rzls_package:is_installed() then
  local rzls_path = vim.fs.joinpath(rzls_package:get_install_path(), "libexec")
  table.insert(
    args,
    "--razorSourceGenerator="
      .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll")
  )
  table.insert(
    args,
    "--razorDesignTimePath="
      .. vim.fs.joinpath(
        rzls_path,
        "Targets",
        "Microsoft.NET.Sdk.Razor.DesignTime.targets"
      )
  )
end

--- @type RoslynNvimConfig
local config = {
  args = args,
  config = {
    capabilities = require("lsp.common").capabilities,
    handlers = require "rzls.roslyn_handlers",
  },
  filewatching = "off",
}

local roslyn_package = mason_registry.get_package "roslyn"
if roslyn_package:is_installed() then
  config.exe = {
    "dotnet",
    vim.fs.joinpath(
      roslyn_package:get_install_path(),
      "libexec",
      "Microsoft.CodeAnalysis.LanguageServer.dll"
    ),
  }
end

require("roslyn").setup(config)
