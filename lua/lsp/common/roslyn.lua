local M = {}

---The shared autocmd group for roslyn servers.
M.augroup = vim.api.nvim_create_augroup("RoslynLanguageServer", {})

---Get the roslyn command for the roslyn language server.
---@return string[]
function M.get_roslyn_cmd()
  local mason_registry = require "mason-registry"

  ---@type string[]
  local cmd = {}

  local roslyn_package = mason_registry.get_package "roslyn"
  if roslyn_package:is_installed() then
    vim.list_extend(cmd, {
      "roslyn",
      "--stdio",
      "--logLevel=Information",
      "--extensionLogDirectory",
      vim.fs.dirname(vim.lsp.get_log_path()),
    })

    local rzls_package = mason_registry.get_package "rzls"
    if rzls_package:is_installed() then
      local rzls_path = vim.fn.expand "$MASON/packages/rzls/libexec"
      vim.list_extend(cmd, {
        "--razorSourceGenerator",
        vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        "--razorDesignTimePath",
        vim.fs.joinpath(
          rzls_path,
          "Targets",
          "Microsoft.NET.Sdk.Razor.DesignTime.targets"
        ),
        "--extension",
        vim.fs.joinpath(
          rzls_path,
          "RazorExtension",
          "Microsoft.VisualStudioCode.RazorExtension.dll"
        ),
      })
    end
  end

  return cmd
end

---Create an autocmd to trigger auto inserts when pressing '/'.
---@param client vim.lsp.Client | nil the LSP client
---@param bufnr number the buffer number
function M.set_up_vs_on_auto_insert_autocmd(client, bufnr)
  if client and (client.name == "roslyn" or client.name == "roslyn_ls") then
    vim.api.nvim_create_autocmd("InsertCharPre", {
      desc = "Roslyn: Trigger an auto insert on '/'.",
      group = M.augroup,
      buffer = bufnr,
      callback = function()
        local char = vim.v.char

        if char ~= "/" then
          return
        end

        require("lsp.vs-on-auto-insert").trigger_request(client, bufnr, char)
      end,
    })
  end
end

return M
