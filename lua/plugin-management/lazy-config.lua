require("lazy").setup("plugin-management.plugins", {
  ui = {
    border = "rounded",
    browser = require("system-compat").get_browser_command(),
  },
})
