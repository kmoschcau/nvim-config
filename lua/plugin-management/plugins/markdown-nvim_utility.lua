--- @type LazyPluginSpec
return {
  "tadmccorkle/markdown.nvim",
  name = "markdown.nvim-utility",
  ft = "markdown",
  -- @type MarkdownConfig -- Does not work well, no optional fields
  opts = {
    mappings = {
      go_curr_heading = "]h",
    },
  },
}
