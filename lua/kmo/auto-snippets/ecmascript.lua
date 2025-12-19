local M = {}

---When typing "await" add "async" to the function declaration if the function
---isn't async already.
function M.add_async()
  vim.api.nvim_feedkeys("t", "n", true)

  local column = vim.api.nvim_win_get_cursor(0)[2]

  -- cspell:disable-next-line
  if vim.api.nvim_get_current_line():sub(column - 3, column) ~= "awai" then
    return
  end

  local function_node = require("kmo.auto-snippets.init").find_node_ancestor({
    "arrow_function",
    "function_declaration",
    "function_expression",
    "method_definition",
  }, vim.treesitter.get_node { ignore_injections = false })
  if not function_node then
    return
  end

  local target_node = function_node:child(0)

  if not target_node then
    return
  end

  if target_node:type() == "accessibility_modifier" then
    target_node = function_node:child(1)
  end

  if not target_node then
    return
  end

  if not target_node or target_node:type() == "async" then
    return
  end

  local start_row, start_col = target_node:start()
  vim.api.nvim_buf_set_text(
    vim.api.nvim_get_current_buf(),
    start_row,
    start_col,
    start_row,
    start_col,
    { "async " }
  )
end

---Register an insert mode keymap to automatically add "async" to the next
---surrounding function, when typing "await".
function M.register_add_async()
  vim.keymap.set("i", "t", M.add_async, { buffer = true })
end

return M
