--- @type LazyPluginSpec
return {
  "tadmccorkle/markdown.nvim",
  name = "markdown.nvim-utility",
  ft = "markdown",
  -- @type MarkdownConfig -- Does not work well, no optional fields
  opts = {
    mappings = {
      inline_surround_toggle = false,
      inline_surround_toggle_line = false,
      inline_surround_delete = false,
      inline_surround_change = false,
      go_curr_heading = "]h",
    },
  },
}
