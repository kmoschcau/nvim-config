local M = {}

local function get_treesitter_and_semantic_at_cursor()
  return {
    semantic_tokens = vim.lsp.semantic_tokens.get_at_pos(),
    treesitter_captures = vim.treesitter.get_captures_at_cursor(),
  }
end

--- Show Treesitter captures and extmark highlights at the cursor position.
--- @return nil
M.show_extmarks_at_cursor = function()
  vim.lsp.util.open_floating_preview(
    vim.split(vim.inspect(get_treesitter_and_semantic_at_cursor()), "\n"),
    "lua",
    { border = "rounded", title = "Semantic + Treesitter" }
  )
end

--- Show the built-in synstack highlight for the cursor position.
--- @return nil
M.show_synstack_highlight = function()
  if not (vim.fn.exists "*synstack" > 0) then
    return
  end

  local line = vim.fn.line "."
  local col = vim.fn.col "."
  local names = {}
  for _, id in ipairs(vim.fn.synstack(line, col)) do
    table.insert(names, vim.fn.synIDattr(id, "name"))
  end

  vim.lsp.util.open_floating_preview(
    vim.split(vim.inspect(names), "\n"),
    "lua",
    { border = "rounded", title = "Synstack" }
  )
end

return M
