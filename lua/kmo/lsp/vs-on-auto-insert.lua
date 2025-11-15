local M = {}

---The capabilities for `textDocument/_vs_onAutoInsert`
M.capabilities = {
  textDocument = {
    _vs_onAutoInsert = { dynamicRegistration = false },
  },
}

---The method name for `textDocument/_vs_onAutoInsert`
M.method_name = "textDocument/_vs_onAutoInsert"

---Trigger a `textDocument/_vs_onAutoInsert` for the given buffer and character.
---@param client vim.lsp.Client the client to send the request to
---@param bufnr number the buffer number
---@param char string the character to trigger for
function M.trigger_request(client, bufnr, char)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row, col = row - 1, col + 1
  local uri = vim.uri_from_bufnr(bufnr)

  local params = {
    _vs_textDocument = { uri = uri },
    _vs_position = { line = row, character = col },
    _vs_ch = char,
    _vs_options = {
      tabSize = vim.bo[bufnr].tabstop,
      insertSpaces = vim.bo[bufnr].expandtab,
    },
  }

  -- NOTE: We should send textDocument/_vs_onAutoInsert request only after
  -- buffer has changed.
  vim.defer_fn(function()
    client:request(
      ---@diagnostic disable-next-line: param-type-mismatch
      M.method_name,
      params,
      M.handler,
      bufnr
    )
  end, 1)
end

---The handler for `textDocument/_vs_onAutoInsert`.
function M.handler(err, result, _)
  if err or not result then
    return
  end

  vim.snippet.expand(result._vs_textEdit.newText)
end

return M
