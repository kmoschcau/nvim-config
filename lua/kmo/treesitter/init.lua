local web_injects = { "css", "javascript" }
local front_end_framework_injects =
  vim.list_extend({ "scss", "typescript" }, web_injects)

local injections = {
  gitcommit = { "diff" },
  html = web_injects,
  markdown = { "mermaid" },
  markdown_inline = { "mermaid" },
  svelte = front_end_framework_injects,
  vue = front_end_framework_injects,
}

local function enable_features(buf)
  vim.treesitter.start(buf)

  vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  if vim.opt_local.foldmethod ~= "manual" then
    vim.opt_local.foldmethod = "expr"
  end
end

local function enable_nvim_treesitter_features(buf)
  if vim.bo[buf].indentexpr == "" then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter.setup", {}),
  callback = function(args)
    local buf = args.buf
    local filetype = args.match

    local language = vim.treesitter.language.get_lang(filetype) or filetype

    local has_nvim_treesitter, nvim_treesitter =
      pcall(require, "nvim-treesitter")

    if vim.treesitter.language.add(language) then
      enable_features(buf)

      if has_nvim_treesitter then
        enable_nvim_treesitter_features(buf)
      end

      return
    end

    if not has_nvim_treesitter then
      return
    end

    local available = nvim_treesitter.get_available()

    local injected = injections[language]
    local all_langs = vim.tbl_filter(function(lang)
      return vim.list_contains(available, lang)
    end, vim.list_extend({ language }, injected or {}))

    if #all_langs < 1 then
      return
    end

    local notification_id = "nvim-treesitter install " .. vim.inspect(all_langs)
    local title = "nvim-treesitter install"
    local symbols = require "kmo.symbols"

    vim.notify("Installing " .. vim.inspect(all_langs), vim.log.levels.INFO, {
      id = notification_id,
      timeout = false,
      title = title,
      opts = function(notification)
        notification.icon = symbols.progress.get_dynamic_spinner()
      end,
    })
    nvim_treesitter.install(all_langs):await(function()
      vim.notify("Installed " .. vim.inspect(all_langs), vim.log.levels.INFO, {
        id = notification_id,
        icon = symbols.progress.done,
        title = title,
      })

      enable_features(buf)

      if has_nvim_treesitter then
        enable_nvim_treesitter_features(buf)
      end
    end)
  end,
})
