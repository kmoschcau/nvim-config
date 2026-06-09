local bash_injected_langs = { "readline" }
local bash_langs = vim.list_extend({ "bash" }, bash_injected_langs)

local ecma_injected_langs = { "html", "jsdoc" }

local javascript_injected_langs = ecma_injected_langs
local javascript_langs =
  vim.list_extend({ "javascript" }, javascript_injected_langs)

local typescript_injected_langs =
  vim.list_extend({ "tsx" }, ecma_injected_langs)
local typescript_langs =
  vim.list_extend({ "typescript" }, typescript_injected_langs)

local html_injected_langs = vim.list_extend({ "css", "json" }, javascript_langs)

local front_end_framework_injected_langs = vim.list_extend(
  vim.list_extend({ "html", "scss" }, html_injected_langs),
  typescript_langs
)

local git_rebase_injected_langs = bash_langs
local git_rebase_langs =
  vim.list_extend({ "git_rebase" }, git_rebase_injected_langs)

local M = {}

---Base buffer filetypes pointing at injected treesitter languages
M.ft_to_injected_languages = {
  astro = vim.list.unique(front_end_framework_injected_langs),
  bash = vim.list.unique(bash_injected_langs),
  dockerfile = vim.list.unique(bash_langs),
  gitconfig = vim.list.unique(bash_langs),
  gitrebase = vim.list.unique(bash_langs),
  gitcommit = vim.list.unique(vim.list_extend({ "diff" }, git_rebase_langs)),
  html = vim.list.unique(html_injected_langs),
  java = { "javadoc" },
  javascript = vim.list.unique(javascript_injected_langs),
  lua = { "c", "luadoc", "luap", "query", "vim" },
  markdown = { "markdown_inline", "mermaid" },
  svelte = vim.list.unique(front_end_framework_injected_langs),
  typescript = vim.list.unique(typescript_injected_langs),
  vue = vim.list.unique(front_end_framework_injected_langs),
  xml = vim.list.unique(vim.list_extend({ "css" }, javascript_langs)),
  yaml = vim.list.unique(bash_langs),
}

return M
