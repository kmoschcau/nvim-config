local editorconfig = require "editorconfig"

local original_indent_size = editorconfig.properties.indent_size

---@diagnostic disable-next-line: duplicate-set-field
editorconfig.properties.indent_size = function(bufnr, val, opts)
  original_indent_size(bufnr, val, opts)

  local v = vim._tointeger(val)
  if not v then
    return
  end

  vim.opt_local.listchars:append(
    require("kmo.indent-markers").get_leadmultispace(v)
  )
end
