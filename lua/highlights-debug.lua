local M = {}

local function transform_extmark(extmarks, extmark)
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local extmark_start = extmark[3]
  local details = extmark[4]
  local extmark_end = details.end_col

  if extmark_start > col or extmark_end < col then
    return
  end

  table.insert(extmarks, {
    hl = details.hl_group,
    priority = details.priority,
  })
end

local function transform_extmarks(results, extmarks, namespace)
  local transformed = {}

  for _, extmark in ipairs(extmarks) do
    transform_extmark(transformed, extmark)
  end

  if #transformed < 1 then
    return
  end

  table.insert(results, {
    extmarks = transformed,
    namespace = namespace,
  })
end

local function get_extmarks_at_cursor()
  local namespaces = vim.api.nvim_get_namespaces()
  local line = unpack(vim.api.nvim_win_get_cursor(0))
  local start = { line - 1, 0 }
  local end_pos = { line - 1, -1 }

  local extmarks = {}
  local treesitter_captures = vim.treesitter.get_captures_at_cursor()

  for namespace, id in pairs(namespaces) do
    transform_extmarks(
      extmarks,
      vim.api.nvim_buf_get_extmarks(0, id, start, end_pos, { details = true }),
      namespace
    )
  end

  return {
    extmarks = extmarks,
    treesitter_captures = treesitter_captures,
  }
end

--- Show Treesitter captures and extmark highlights at the cursor position.
--- @return nil
M.show_extmarks_at_cursor = function()
  vim.lsp.util.open_floating_preview(
    vim.split(vim.inspect(get_extmarks_at_cursor()), "\n"),
    "lua",
    { border = "rounded", title = "Extmarks" }
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
