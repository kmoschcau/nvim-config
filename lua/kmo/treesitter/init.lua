---The common injections for web languages
local web_injects = { "css", "javascript", "jsdoc" }
---The common injections for web front-end frameworks
local front_end_framework_injects =
  vim.list_extend({ "scss", "typescript" }, web_injects)

---Base buffer filetypes pointing at injected filetypes
local language_injections = {
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

---Enables nvim-treesitter features for the given buffer.
---@param buf integer the buffer number
local function enable_features(buf)
  vim.treesitter.start(buf)

  vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  if vim.opt_local.foldmethod ~= "manual" then
    vim.opt_local.foldmethod = "expr"
  end
end

---Enables nvim-treesitter features for the given buffer.
---@param buf integer the buffer number
local function enable_nvim_treesitter_features(buf)
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter.setup", {}),
  callback = function(args)
    local buf = args.buf
    local filetype = args.match

    local buffer_language = vim.treesitter.language.get_lang(filetype)
      or filetype

    local all_languages = vim.list_extend(
      { buffer_language },
      language_injections[buffer_language] or {}
    )

    local missing_languages = vim.tbl_filter(function(lang)
      return not (vim.treesitter.language.add(lang) or false)
    end, all_languages)

    local has_nvim_treesitter, nvim_treesitter =
      pcall(require, "nvim-treesitter")

    if #missing_languages < 1 then
      enable_features(buf)

      if has_nvim_treesitter then
        enable_nvim_treesitter_features(buf)
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

      enable_features(buf)

      if has_nvim_treesitter then
        enable_nvim_treesitter_features(buf)
      end
    end)
  end,
})
