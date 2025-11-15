---@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    require("kmo.lsp.common").create_source_actions_user_command(client, bufnr)
  end,
  -- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
  settings = vim.tbl_extend(
    "error",
    require("kmo.lsp.common.vscode-css").settings,
    require("kmo.lsp.common.tsserver").settings
  ),
}
