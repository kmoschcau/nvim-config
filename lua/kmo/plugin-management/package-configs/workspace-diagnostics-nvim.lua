vim.api.nvim_create_user_command("WorkspaceDiagnostics", function()
  for _, client in ipairs(vim.lsp.get_clients()) do
    require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
  end
end, {
  bar = true,
  desc = "Diagnostics: Run workspace diagnostics.",
})
