--- @type LazyPluginSpec
return {
  "tadmccorkle/markdown.nvim",
  ft = "markdown",
  -- @type MarkdownConfig -- Does not work well, no optional fields
  opts = {
    mappings = {
      go_curr_heading = "]h",
    },
  },
}
