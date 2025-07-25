-- Adapted from
-- https://github.com/nvimtools/none-ls.nvim/blob/main/lua/null-ls/helpers/cache.lua

local next_key = 0

local M = {}

function M._reset()
  M.cache = {}
end

M._reset()

---Creates a function that caches the output of a callback, indexed by a buffer
---number.
---@generic T
---@param cb fun(event_args: vim.api.keyset.create_autocmd.callback_args): T
---@return fun(event_args: vim.api.keyset.create_autocmd.callback_args): T
function M.by_bufnr(cb)
  -- Assign next available key, since we just want to avoid collisions.
  local key = next_key
  next_key = next_key + 1

  ---@param event_args vim.api.keyset.create_autocmd.callback_args
  return function(event_args)
    local bufnr = event_args.buf

    if M.cache[key] == nil then
      M.cache[key] = {}
    end

    -- If we haven't cached a value yet, get it from cb.
    if M.cache[key][bufnr] == nil then
      -- Make sure we always store a value so we know we've already called cb.
      M.cache[key][bufnr] = cb(event_args)
    end

    return M.cache[key][bufnr]
  end
end

return M
