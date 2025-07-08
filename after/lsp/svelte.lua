---@type vim.lsp.Config
return {
  -- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
  settings = vim.tbl_extend(
    "error",
    require("lsp.common.vscode-css").settings,
    require("lsp.common.tsserver").settings
  ),
}
