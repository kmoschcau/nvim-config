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

-- TODO: Remove once I have an alternative to markdown-preview.nvim
vim.api.nvim_create_user_command("LazyBuild", function()
  vim.cmd [[Lazy load markdown-preview.nvim]]
  vim.cmd [[Lazy build all]]
end, {
  bar = true,
  desc = "Lazy: Build all plugins that need building.",
})
