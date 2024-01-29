--- @type LazyPluginSpec
return {
  "euclio/vim-markdown-composer",
  build = "cargo build --release",
  init = function()
    vim.g.markdown_composer_autostart = 0
    vim.g.markdown_composer_browser =
      require("system-compat").get_browser_command()
  end,
}
