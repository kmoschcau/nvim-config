-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "cappyzawa/trim.nvim",
  -- NOTE: This breaks last substitution functionality.
  -- see: https://github.com/cappyzawa/trim.nvim/issues/27
  enabled = false,
  opts = {
    ft_blocklist = { "markdown" },
  },
}
