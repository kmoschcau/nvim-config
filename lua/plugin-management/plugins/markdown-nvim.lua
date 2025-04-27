-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "tadmccorkle/markdown.nvim",
  ft = "markdown",
  -- @type MarkdownConfig -- Does not work well, no optional fields
  opts = {
    mappings = {
      inline_surround_toggle = false,
      inline_surround_toggle_line = false,
      inline_surround_delete = false,
      inline_surround_change = false,
      link_follow = false,
      go_curr_heading = "]h",
    },
  },
}
