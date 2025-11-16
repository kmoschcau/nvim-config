-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "artemave/workspace-diagnostics.nvim",
  init = function()
    vim.api.nvim_create_user_command("WorkspaceDiagnostics", function()
      for _, client in ipairs(vim.lsp.get_clients()) do
        require("workspace-diagnostics").populate_workspace_diagnostics(
          client,
          0
        )
      end
    end, {
      bar = true,
      desc = "Diagnostics: Run workspace diagnostics.",
    })
  end,
}
