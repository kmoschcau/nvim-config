local M = {}

---Check whether to enable cspell in a specific buffer
---@param buftype string the buftype of the buffer
---@param filetype string the filetype of the buffer
---@return boolean enable whether to enable cspell in the buffer
function M.enable_cspell(buftype, filetype)
  return not vim.list_contains({ "help" }, buftype)
    and not vim.list_contains(
      { "cmd", "msg", "pager", "dialog", "fugitive" },
      filetype
    )
end

return M
