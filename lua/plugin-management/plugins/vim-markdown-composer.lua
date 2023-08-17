return {
  "euclio/vim-markdown-composer",
  build = "cargo build --release",
  init = function()
    -- Whether the server should automatically start when a markdown file is opened.
    vim.g.markdown_composer_autostart = 0

    -- Pick the right browser for the system we are running in
    vim.g.markdown_composer_browser =
      require("system-compat").get_browser_command()
  end,
}
