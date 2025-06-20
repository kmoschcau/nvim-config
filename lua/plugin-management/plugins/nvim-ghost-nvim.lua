-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "subnut/nvim-ghost.nvim",
  init = function()
    local patterns = {
      "*github.com",
      "dev.azure.com",
    }

    local hard_break_sites_patterns = {
      "*github.com",
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

    vim.api.nvim_create_autocmd("User", {
      desc = "nvim-ghost: Set textwidth to 0 for sites that break lines in the output on line breaks",
      group = augroup,
      pattern = table.concat(hard_break_sites_patterns, ","),
      callback = function()
        vim.opt_local.textwidth = 0
      end,
    })
  end,
}
