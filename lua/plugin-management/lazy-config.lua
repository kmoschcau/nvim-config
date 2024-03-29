require("lazy").setup("plugin-management.plugins", {
  dev = {
    path = "~/Code",
    patterns = { "kmoschcau" },
  },
  ui = {
    border = "rounded",
    browser = require("system-compat").get_browser_command(),
  },
  checker = {
    enabled = true,
  },
})
