-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "iamcco/markdown-preview.nvim",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = "markdown",
  config = function()
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_combine_preview = 1
  end,
}
