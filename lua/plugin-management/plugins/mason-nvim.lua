local symbols = require "symbols"

local always_install = {}

if vim.fn.has "win32" == 1 then
  table.insert(always_install, "cspell")
else
  -- This seems to cause weird lag spikes on Windows, use it via nvim-lint
  -- instead.
  table.insert(always_install, "cspell-lsp")
end

local prettier = "prettier"

local pkgs_by_ft = {
  -- cspell:disable
  astro = { prettier },
  cs = { "csharpier", "netcoredbg" },
  cshtml = { "roslyn", "rzls" },
  css = { prettier },
  html = { "markuplint" },
  java = {
    "checkstyle",
    "google-java-format",
    "java-debug-adapter",
    "java-test",
  },
  javascript = { prettier },
  javascriptreact = { prettier },
  jq = { "jq" },
  json = { "jsonlint", prettier },
  ["json.cloudformation"] = { "cfn-lint" },
  jsonc = { prettier },
  less = { prettier },
  kotlin = { "ktlint" },
  lua = { "selene", "stylua" },
  markdown = { "markdownlint", "proselint" },
  ocaml = { "ocamlformat" },
  razor = { "roslyn", "rzls" },
  sass = { prettier },
  scss = { prettier },
  sh = { "shellharden", "shfmt" },
  svelte = { "markuplint", prettier },
  tex = { "latexindent", "proselint" },
  tf = { "trivy" },
  ["terraform-vars"] = { "trivy" },
  typescript = { prettier },
  typescriptreact = { prettier },
  vue = { "markuplint", prettier },
  yaml = { "yamllint", prettier },
  ["yaml.cloudformation"] = { "cfn-lint", "yamllint" },
  -- cspell:enable
}

local lsp_to_mason_package = {
  -- cspell:disable
  astro = "astro-language-server",
  bashls = "bash-language-server",
  cssls = "css-lsp",
  denols = "deno",
  -- ember = "ember-language-server",
  eslint = "eslint",
  fish_lsp = "fish-lsp",
  -- gh_actions_ls = "gh-actions-language-server",
  gradle_ls = "gradle-language-server",
  helm_ls = "helm-ls",
  html = "html-lsp",
  jedi_language_server = "jedi-language-server",
  jqls = "jq-lsp",
  jsonls = "json-lsp",
  kotlin_language_server = "kotlin-language-server",
  lemminx = "lemminx",
  lua_ls = "lua-language-server",
  marksman = "marksman",
  -- omnisharp = "omnisharp",
  phpactor = "phpactor",
  powershell_es = "powershell-editor-services",
  prosemd_lsp = "prosemd-lsp",
  quick_lint_js = "quick-lint-js",
  roslyn_ls = "roslyn",
  ruff = "ruff",
  rust_analyzer = "rust-analyzer",
  stylelint_lsp = "stylelint-lsp",
  somesass_ls = "some-sass-language-server",
  svelte = "svelte-language-server",
  tailwindcss = "tailwindcss-language-server",
  terraform_lsp = "terraform-ls",
  texlab = "texlab",
  ts_ls = "typescript-language-server",
  vale_ls = "vale-ls",
  vimls = "vim-language-server",
  vtsls = "vtsls",
  vue_ls = "vue-language-server",
  yamlls = "yaml-language-server",
  -- cspell:enable
}

local function add_package_names_from_lsp_config()
  for server_name, package_name in pairs(lsp_to_mason_package) do
    local server_config = vim.lsp.config[server_name]
    if server_config then
      local filetypes = server_config.filetypes

      if filetypes and #filetypes > 0 then
        for _, filetype in ipairs(filetypes) do
          if pkgs_by_ft[filetype] == nil then
            pkgs_by_ft[filetype] = { package_name }
          else
            table.insert(pkgs_by_ft[filetype], package_name)
          end
        end
      end
    end
  end
end

local function install_pkg(pkg_name)
  local has_reg, reg = pcall(require, "mason-registry")
  if not has_reg or not reg.has_package(pkg_name) then
    return
  end

  local pkg = reg.get_package(pkg_name)
  if pkg:is_installed() or pkg:is_installing() then
    return
  end

  local notification_id = "mason_install_" .. pkg_name

  vim.notify("Installing " .. pkg_name, vim.log.levels.INFO, {
    id = notification_id,
    timeout = false,
    title = "mason.nvim",
    opts = function(notification)
      notification.icon = symbols.progress.get_dynamic_spinner()
    end,
  })
  pkg:install(nil, function(success, error_or_receipt)
    if success then
      vim.notify(
        pkg_name .. " was successfully installed.",
        vim.log.levels.INFO,
        {
          id = notification_id,
          icon = symbols.progress.done,
          title = "mason.nvim",
        }
      )
    else
      vim.notify(
        string.format(
          "Could not install %s:\n%s",
          pkg_name,
          vim.inspect(error_or_receipt)
        ),
        vim.log.levels.ERROR,
        { id = notification_id, title = "mason.nvim" }
      )
    end
  end)
end

---Install the given packages
---@param pkg_names string[] the names of the packages to install
local function install_packages(pkg_names)
  if pkg_names == nil then
    return
  end

  for _, pkg_name in ipairs(pkg_names) do
    install_pkg(pkg_name)
  end
end

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "mason-org/mason.nvim",
  build = function()
    local has_reg, reg = pcall(require, "mason-registry")

    if not has_reg then
      return
    end

    local refresh_notification_id = "mason_nvim_registry_refresh"

    vim.notify("Refreshing registries…", vim.log.levels.INFO, {
      id = refresh_notification_id,
      timeout = false,
      title = "mason.nvim",
      opts = function(notification)
        notification.icon = symbols.progress.get_dynamic_spinner()
      end,
    })
    reg.refresh(function(success, updated_registries)
      if success then
        vim.notify(
          #updated_registries > 0
              and string.format(
                "Successfully refreshed %d registries.",
                #updated_registries
              )
            or "No registries needed refreshing.",
          vim.log.levels.INFO,
          {
            id = refresh_notification_id,
            icon = symbols.progress.done,
            title = "mason.nvim",
          }
        )
        install_packages(always_install)
      else
        vim.notify("Could not refresh the registries.", vim.log.levels.ERROR, {
          id = refresh_notification_id,
          title = "mason.nvim",
        })
      end
    end)
  end,
  opts = {
    registries = {
      -- cspell:disable
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
      -- cspell:enable
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    add_package_names_from_lsp_config()

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = vim.api.nvim_create_augroup("MasonNvimInstall", {}),
      desc = "mason.nvim: Automatically install packages for specific file types.",
      callback = function()
        install_packages(pkgs_by_ft[vim.bo.filetype])
      end,
    })
  end,
}
