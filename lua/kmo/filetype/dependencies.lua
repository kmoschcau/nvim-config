local javascript_dependencies = { "ecma", "jsdoc" }

local typescript_dependencies =
  vim.list.unique(vim.list_extend({}, javascript_dependencies))

local web_dependencies =
  vim.list.unique(vim.list_extend({ "css" }, javascript_dependencies))

local front_end_framework_dependencies = vim.list.unique(
  vim.list_extend(
    vim.list_extend({ "scss" }, web_dependencies),
    typescript_dependencies
  )
)

---Base buffer filetypes pointing at injected and inherited filetypes
return {
  astro = front_end_framework_dependencies,
  gitcommit = { "diff" },
  html = web_dependencies,
  java = { "javadoc" },
  javascript = javascript_dependencies,
  lua = { "luadoc" },
  markdown = { "mermaid" },
  markdown_inline = { "mermaid" },
  svelte = front_end_framework_dependencies,
  typescript = typescript_dependencies,
  vue = front_end_framework_dependencies,
}
