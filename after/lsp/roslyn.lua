---@type vim.lsp.Config
return {
  cmd = require("lsp.common.roslyn").get_roslyn_cmd(),
  settings = vim.lsp.config.roslyn_ls.settings,
}
