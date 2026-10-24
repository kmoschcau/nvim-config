-- cspell:words lazydev luvit wezterm

require("lazydev").setup {
  ---@type lazydev.Library.spec[]
  library = {
    "luvit-meta/library",
    { path = "wezterm-types", mods = { "wezterm" } },
  },
}
