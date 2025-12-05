local mason_utils = require "kmo.plugin-management.mason-utils"

local M = {}

---The shared autocmd group for roslyn servers.
M.augroup = vim.api.nvim_create_augroup("RoslynLanguageServer", {})

---Get the roslyn command for the roslyn language server.
---@return string[]
function M.get_roslyn_cmd()
  ---@type string[]
  local cmd = {}

  if not mason_utils.is_package_installed "roslyn" then
    return cmd
  end

  vim.list_extend(cmd, {
    "roslyn",
    "--stdio",
    "--logLevel=Information",
    "--extensionLogDirectory",
    vim.fs.dirname(vim.lsp.log.get_filename()),
  })

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

        require("kmo.lsp.vs-on-auto-insert").trigger_request(
          client,
          bufnr,
          char
        )
      end,
    })
  end
end

return M
