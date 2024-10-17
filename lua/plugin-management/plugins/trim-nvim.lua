-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "cappyzawa/trim.nvim",
  opts = {
    ft_blocklist = { "markdown" }
  }
}
