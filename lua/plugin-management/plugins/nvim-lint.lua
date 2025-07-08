-- cspell:words neoconf

---@type table<string, string[]>
local linters_by_ft = {
  -- cspell:disable
  fish = { "fish" },
  html = { "markuplint" },
  java = { "checkstyle", "pmd" },
  json = { "jsonlint" },
  ["json.cloudformation"] = { "cfn_lint" },
  kotlin = { "ktlint" },
  lua = { "selene" },
  markdown = { "markdownlint", "proselint" },
  svelte = { "markuplint" },
  tex = { "proselint" },
  tf = { "trivy" },
  ["terraform-vars"] = { "trivy" },
  vue = { "markuplint" },
  yaml = { "actionlint", "yamllint" },
  ["yaml.cloudformation"] = { "cfn_lint", "yamllint" },
  -- cspell:enable
}

---@class lint.LinterOverrideConfig
---@field args? string[]
---@field condition? fun(event_args: vim.api.keyset.create_autocmd.callback_args): boolean, boolean?
---@field ignore_exitcode? boolean
---@field prepend_args? string[]

---@alias lint.LinterOverride lint.Linter | lint.LinterOverrideConfig

local cache = require "cache"

---@param timeout_ms number
---@param fn function
local function debounce(timeout_ms, fn)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(timeout_ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

---@param name string
---@return lint.LinterOverride?
local function get_effective_linter(name)
  local nvim_lint = require "lint"
  local found_linter = nvim_lint.linters[name]
  if not found_linter then
    return nil
  end

  if type(found_linter) == "function" then
    return found_linter()
  else
    return found_linter
  end
end

---@param linter_overrides table<string, lint.LinterOverride>
local function merge_linter_configurations(linter_overrides)
  local nvim_lint = require "lint"

  for name, linter_override in pairs(linter_overrides) do
    local nvim_lint_linter = get_effective_linter(name)

    if
      type(linter_override) == "table" and type(nvim_lint_linter) == "table"
    then
      local merged_linter =
        vim.tbl_deep_extend("force", nvim_lint_linter, linter_override)
      if type(linter_override.prepend_args) == "table" then
        merged_linter.args = vim.list_extend(
          linter_override.prepend_args,
          nvim_lint.linters[name].args or {}
        )
      end
      nvim_lint.linters[name] = merged_linter --[[@as lint.Linter]]
    else
      nvim_lint.linters[name] = linter_override --[[@as lint.Linter]]
    end
  end

  nvim_lint.linters_by_ft = linters_by_ft
end

-- Use nvim-lint's logic first:
-- * checks if linters exist for the full filetype first
-- * otherwise will split filetype by "." and add all those linters
-- * this differs from conform.nvim which only uses the first filetype that has a formatter
---@param event_args vim.api.keyset.create_autocmd.callback_args
local function do_lint(event_args)
  local nvim_lint = require "lint"

  local names =
    vim.list_extend({}, nvim_lint._resolve_linter_by_ft(vim.bo.filetype))

  if #names == 0 then
    vim.list_extend(names, nvim_lint.linters_by_ft["_"] or {})
  end

  vim.list_extend(names, nvim_lint.linters_by_ft["*"] or {})

  names = vim.tbl_filter(function(name)
    local nvim_lint_linter = get_effective_linter(name)

    if type(nvim_lint_linter) ~= "table" then
      vim.notify("Linter not found: " .. name, vim.log.levels.WARN, {
        title = "nvim-lint",
      })

      return false
    end

    if
      not nvim_lint_linter.stdin
      and not vim.list_contains(
        { "BufReadPost", "BufWritePost" },
        event_args.event
      )
    then
      return false
    end

    if type(nvim_lint_linter.condition) == "function" then
      return nvim_lint_linter.condition(event_args)
    end

    return true
  end, names)

  if #names > 0 then
    vim.notify(
      string.format(
        "Event: %s\nLinting with: %s",
        event_args.event,
        vim.inspect(names)
      ),
      vim.log.levels.DEBUG,
      {
        title = "nvim-lint",
      }
    )
    nvim_lint.try_lint(names)
  end
end

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "mfussenegger/nvim-lint",
  dependencies = {
    -- cspell:disable
    "folke/neoconf.nvim",
    -- cspell:enable
  },
  config = function()
    -- TODO: extract this into override functions.
    local config = require("neoconf").get(
      "linters",
      require("neoconf-schemas.linters").defaults
    )

    local checkstyle_config = config.java.checkstyle

    local checkstyle_args = { "-f", "sarif", "-c", checkstyle_config.config }

    if checkstyle_config.options then
      for _, arg in ipairs(vim.fn.split(checkstyle_config.options)) do
        table.insert(checkstyle_args, arg)
      end
    end

    local pmd_config = config.java.pmd

    local pmd_args =
      { "check", "--format", "sarif", "--rulesets", pmd_config.rulesets }

    if pmd_config.cache then
      table.insert(pmd_args, "--cache")
      table.insert(pmd_args, pmd_config.cache)
    else
      table.insert(pmd_args, "--no-cache")
    end

    table.insert(pmd_args, "--dir")

    ---@type table<string, lint.LinterOverrideConfig>
    local linter_overrides = {
      actionlint = {
        condition = cache.by_bufnr(function(event_args)
          return vim
            .regex([[\.git\%(hub\|ea\)]])
            :match_str(vim.fs.normalize(event_args.match)) ~= nil
        end),
      },
      checkstyle = {
        args = checkstyle_args,
      },
      markdownlint = {
        condition = function()
          return not vim.list_contains({ "help", "nofile" }, vim.bo.buftype)
        end,
      },
      pmd = {
        args = pmd_args,
      },
      proselint = {
        condition = function()
          return not vim.list_contains({ "help", "nofile" }, vim.bo.buftype)
        end,
      },
      selene = {
        condition = cache.by_bufnr(function(event_args)
          return #vim.fs.find("selene.toml", {
            path = event_args.match,
            upward = true,
          }) > 0
        end),
      },
    }

    merge_linter_configurations(linter_overrides)

    vim.api.nvim_create_autocmd(
      { "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" },
      {
        desc = "Try to run nvim-lint linters.",
        group = vim.api.nvim_create_augroup("nvim-lint", {}),
        callback = debounce(100, do_lint),
      }
    )
  end,
}
