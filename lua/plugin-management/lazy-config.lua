require("lazy").setup("plugin-management.plugins", {
  checker = {
    enabled = true,
  },
  dev = {
    path = "~/Code",
    patterns = { "kmoschcau" },
  },
  install = {
    missing = false,
  },
  ui = {
    border = "rounded",
    browser = require("system-compat").get_browser_command(),
  },
})
