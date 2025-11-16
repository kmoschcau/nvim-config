-- selene: allow(mixed_table)
return {
  -- cspell:disable-next-line
  "lucaSartore/nvim-dap-exception-breakpoints",
  config = function()
    vim.api.nvim_create_user_command(
      "DapExceptionBreakpoints",
      require "nvim-dap-exception-breakpoints",
      {
        bar = true,
        desc = "Dap: Open options dialog for exception breakpoints.",
      }
    )
  end,
}
