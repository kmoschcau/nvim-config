local M = {}

---Gets the leadmultispace value for the given shiftwidth.
---@param shiftwidth integer
---@return string
function M.get_leadmultispace(shiftwidth)
  return string.format(
    "leadmultispace:%s%s",
    "│",
    string.rep(" ", shiftwidth - 1)
  )
end

---Sets up the necessary autocommands to modify 'listchars' when any of the
---indent options are set.
function M.set_up_autocmds()
  local augroup = vim.api.nvim_create_augroup("kmo.indent-markers", {})

  vim.api.nvim_create_autocmd("OptionSet", {
    desc = "Automatically set the listchars option's leadmultispace when setting shiftwidth.",
    group = augroup,
    pattern = "shiftwidth",
    callback = function()
      local is_local = vim.v.option_type == "local"

      local new_value = vim.v.option_new
      if new_value == 0 then
        ---@diagnostic disable-next-line: param-type-mismatch
        new_value = is_local and vim.opt_local.tabstop:get()
          or vim.opt_global.tabstop:get()
      end

      local new_leadmultispace = M.get_leadmultispace(new_value)

      if is_local then
        vim.opt_local.listchars:append(new_leadmultispace)
      else
        vim.opt_global.listchars:append(new_leadmultispace)
      end
    end,
  })

  vim.api.nvim_create_autocmd("OptionSet", {
    desc = "Automatically set the listchars option's leadmultispace when setting tabstop while shiftwidth is 0.",
    group = augroup,
    pattern = "tabstop",
    callback = function()
      local is_local = vim.v.option_type == "local"

      ---@diagnostic disable-next-line: param-type-mismatch
      local shiftwidth = is_local and vim.opt_local.shiftwidth:get()
        or vim.opt_global.shiftwidth:get()
      if shiftwidth ~= 0 then
        return
      end

      local new_value = vim.v.option_new

      local new_leadmultispace = M.get_leadmultispace(new_value)

      if is_local then
        vim.opt_local.listchars:append(new_leadmultispace)
      else
        vim.opt_global.listchars:append(new_leadmultispace)
      end
    end,
  })
end

return M
