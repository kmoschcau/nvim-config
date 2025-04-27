--- @type vim.lsp.Config
return {
  -- FIXME: This isn't overriding the default for some reason.
  cmd = require("lsp.helpers").get_roslyn_cmd(),
}
