---@diagnostic disable-next-line: missing-fields
require("lazy").setup("plugin-management.plugins", {
  checker = {
    enabled = true,
  },
  dev = {
    path = "~/Code",
    patterns = {
      -- cspell:disable
      "kmoschcau",
      -- cspell:enable
    },
  },
  install = {
    missing = false,
  },
  ui = {
    border = "rounded",
    browser = require("system-compat").get_browser_command(),
  },
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Lazy.nvim: Remove the border from the backdrop window",
  pattern = "lazy_backdrop",
  group = vim.api.nvim_create_augroup("lazy.nvim-winborder", { clear = true }),
  callback = function(args)
    for _, window_id in ipairs(vim.fn.win_findbuf(args.buf)) do
      vim.api.nvim_win_set_config(window_id, { border = "none" })
    end
  end,
})

-- TODO: Remove once I have an alternative to markdown-preview.nvim
vim.api.nvim_create_user_command("LazyBuild", function()
  vim.cmd [[Lazy load markdown-preview.nvim]]
  vim.cmd [[Lazy build all]]
end, {
  bar = true,
  desc = "Lazy: Build all plugins that need building.",
})
