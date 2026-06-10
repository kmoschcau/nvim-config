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

---Base buffer treesitter languages pointing at injected treesitter languages
local injected_languages = {
  astro = vim.list.unique(front_end_framework_injected_langs),
  bash = vim.list.unique(bash_injected_langs),
  dockerfile = vim.list.unique(bash_langs),
  git_config = vim.list.unique(bash_langs),
  git_rebase = vim.list.unique(bash_langs),
  gitcommit = vim.list.unique(vim.list_extend({ "diff" }, git_rebase_langs)),
  html = vim.list.unique(html_injected_langs),
  java = { "javadoc" },
  javascript = vim.list.unique(javascript_injected_langs),
  lua = { "c", "luadoc", "luap", "query", "vim" },
  markdown = { "markdown_inline", "mermaid" },
  markdown_inline = { "mermaid" },
  svelte = vim.list.unique(front_end_framework_injected_langs),
  typescript = vim.list.unique(typescript_injected_langs),
  vue = vim.list.unique(front_end_framework_injected_langs),
  xml = vim.list.unique(vim.list_extend({ "css" }, javascript_langs)),
  yaml = vim.list.unique(bash_langs),
}

---Enables vim.treesitter features for the given buffer.
---@param buf integer the buffer number
---@param buffer_language string the buffer treesitter language
local function enable_features(buf, buffer_language)
  vim.treesitter.start(buf)

  if
    #vim.treesitter.query.get_files(buffer_language, "folds") > 0
    and vim.opt_local.foldmethod ~= "manual"
  then
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldmethod = "expr"
  end
end

---Enables nvim-treesitter features for the given buffer.
---@param buf integer the buffer number
---@param buffer_language string the buffer treesitter language
local function enable_nvim_treesitter_features(buf, buffer_language)
  if #vim.treesitter.query.get_files(buffer_language, "indents") > 0 then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter.setup", {}),
  callback = function(args)
    local buf = args.buf
    local filetype = args.match

    local buffer_language = vim.treesitter.language.get_lang(filetype)
      or filetype

    local base_and_injected_languages = vim.list.unique(
      vim.list_extend(
        { buffer_language },
        injected_languages[buffer_language] or {}
      )
    )

    local missing_languages = vim.tbl_filter(function(lang)
      return not (vim.treesitter.language.add(lang) or false)
    end, base_and_injected_languages)

    local has_nvim_treesitter, nvim_treesitter =
      pcall(require, "nvim-treesitter")

    if #missing_languages < 1 then
      enable_features(buf, buffer_language)

      if has_nvim_treesitter then
        enable_nvim_treesitter_features(buf, filetype)
      end

      return
    end

    if not has_nvim_treesitter then
      return
    end

    local available_languages = nvim_treesitter.get_available()

    local filtered_languages = vim.tbl_filter(function(lang)
      return vim.list_contains(available_languages, lang)
    end, missing_languages)

    if #filtered_languages < 1 then
      return
    end

    local notification_id = "nvim-treesitter install "
      .. vim.inspect(filtered_languages)
    local title = "nvim-treesitter install"
    local symbols = require "kmo.symbols"

    vim.notify(
      "Installing " .. vim.inspect(filtered_languages),
      vim.log.levels.INFO,
      {
        id = notification_id,
        timeout = false,
        title = title,
        opts = function(notification)
          notification.icon = symbols.progress.get_dynamic_spinner()
        end,
      }
    )
    nvim_treesitter.install(filtered_languages):await(function()
      vim.notify(
        "Installed " .. vim.inspect(filtered_languages),
        vim.log.levels.INFO,
        {
          id = notification_id,
          icon = symbols.progress.done,
          title = title,
        }
      )

      enable_features(buf, buffer_language)

      if has_nvim_treesitter then
        enable_nvim_treesitter_features(buf, buffer_language)
      end
    end)
  end,
})
