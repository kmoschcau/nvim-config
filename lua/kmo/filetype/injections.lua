---The common injections for web languages
local web_injects = { "css", "javascript", "jsdoc" }
---The common injections for web front-end frameworks
local front_end_framework_injects =
  vim.list_extend({ "scss", "typescript" }, web_injects)

---Base buffer filetypes pointing at injected filetypes
return {
  astro = front_end_framework_injects,
  gitcommit = { "diff" },
  html = web_injects,
  java = { "javadoc" },
  javascript = { "jsdoc" },
  lua = { "luadoc" },
  markdown = { "mermaid" },
  markdown_inline = { "mermaid" },
  svelte = front_end_framework_injects,
  typescript = { "jsdoc" },
  vue = front_end_framework_injects,
}
