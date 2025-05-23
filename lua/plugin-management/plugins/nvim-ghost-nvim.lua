-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "subnut/nvim-ghost.nvim",
  init = function()
    local patterns = {
      "*github.com",
      "dev.azure.com",
    }

    local augroup =
      vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", {})

    vim.api.nvim_create_autocmd("User", {
      desc = "nvim-ghost: Set markdown filetype",
      group = augroup,
      pattern = table.concat(patterns, ","),
      callback = function()
        vim.opt.filetype = "markdown"
      end,
    })
  end,
}
