-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "subnut/nvim-ghost.nvim",
  init = function()
    local augroup =
      vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", {})

    vim.api.nvim_create_autocmd("User", {
      desc = "nvim-ghost: Set markdown filetype",
      group = augroup,
      pattern = "*github.com",
      callback = function()
        vim.opt.filetype = "markdown"
      end,
    })
  end,
}
