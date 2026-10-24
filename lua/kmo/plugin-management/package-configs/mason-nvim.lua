-- cspell:disable
local json_pkgs = { "dprint", "jsonlint", "prettier", "oxfmt" }
local yaml_pkgs = { "dprint", "yamllint", "prettier", "oxfmt" }
-- cspell:enable

local pkgs_by_ft = {
  -- cspell:disable
  astro = { "dprint", "emmet-language-server", "prettier" },
  cs = { "csharpier", "netcoredbg" },
  cshtml = { "emmet-language-server", "roslyn" },
  css = { "dprint", "prettier", "oxfmt" },
  handlebars = { "dprint", "oxfmt" },
  html = { "dprint", "emmet-language-server", "markuplint", "oxfmt" },
  java = {
    "checkstyle",
    "google-java-format",
    "java-debug-adapter",
    "java-test",
    "jdtls",
  },
  javascript = { "dprint", "prettier", "oxfmt" },
  javascriptreact = { "dprint", "emmet-language-server", "prettier", "oxfmt" },
  jq = { "jq" },
  json = { "dprint", "jsonlint", "prettier", "oxfmt" },
  json5 = { "prettier", "oxfmt" },
  ["json.cloudformation"] = vim.list_extend({ "cfn-lint" }, json_pkgs),
  jsonc = { "dprint", "prettier", "oxfmt" },
  less = { "dprint", "prettier", "oxfmt" },
  kotlin = { "ktlint" },
  lua = { "selene", "stylua" },
  markdown = { "proselint", "oxfmt" },
  ocaml = { "ocamlformat" },
  razor = { "emmet-language-server", "roslyn" },
  sass = { "dprint", "prettier", "oxfmt" },
  scss = { "dprint", "prettier", "oxfmt" },
  sh = { "shellharden", "shfmt" },
  svelte = { "dprint", "emmet-language-server", "markuplint", "prettier" },
  systemd = { "systemdlint" },
  tex = { "latexindent", "proselint" },
  tf = { "trivy" },
  ["terraform-vars"] = { "trivy" },
  toml = { "oxfmt" },
  typescript = { "dprint", "prettier", "oxfmt" },
  typescriptreact = { "dprint", "emmet-language-server", "prettier", "oxfmt" },
  vue = {
    "dprint",
    "emmet-language-server",
    "markuplint",
    "prettier",
    "oxfmt",
  },
  yaml = yaml_pkgs,
  ["yaml.cloudformation"] = vim.list_extend({ "cfn-lint" }, yaml_pkgs),
  -- cspell:enable
}

local lsp_to_mason_package = {
  -- cspell:disable
  astro = "astro-language-server",
  azure_pipelines_ls = "azure-pipelines-language-server",
  bashls = "bash-language-server",
  cssls = "css-lsp",
  denols = "deno",
  docker_compose_language_service = "docker-compose-language-service",
  docker_language_server = "docker-language-server",
  dockerls = "dockerfile-language-server",
  -- ember = "ember-language-server",
  fish_lsp = "fish-lsp",
  -- gh_actions_ls = "gh-actions-language-server",
  gradle_ls = "gradle-language-server",
  helm_ls = "helm-ls",
  html = "html-lsp",
  jqls = "jq-lsp",
  jsonls = "json-lsp",
  kotlin_language_server = "kotlin-language-server",
  lemminx = "lemminx",
  lua_ls = "lua-language-server",
  marksman = "marksman",
  -- omnisharp = "omnisharp",
  oxlint = "oxlint",
  phpactor = "phpactor",
  phpantom_lsp = "phpantom_lsp",
  powershell_es = "powershell-editor-services",
  prosemd_lsp = "prosemd-lsp",
  roslyn_ls = "roslyn",
  ruff = "ruff",
  rumdl = "rumdl",
  rust_analyzer = "rust-analyzer",
  stylelint_lsp = "stylelint-language-server",
  somesass_ls = "some-sass-language-server",
  svelte = "svelte-language-server",
  systemd_lsp = "systemd-lsp",
  tailwindcss = "tailwindcss-language-server",
  taplo = "taplo",
  terraform_lsp = "terraform-ls",
  texlab = "texlab",
  tombi = "tombi",
  ts_ls = "typescript-language-server",
  ts_query_ls = "ts_query_ls",
  vale_ls = "vale-ls",
  vimls = "vim-language-server",
  vtsls = "vtsls",
  vue_ls = "vue-language-server",
  yamlls = "yaml-language-server",
  zuban = "zuban",
  -- cspell:enable
}

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

require("mason").setup {
  registries = {
    -- cspell:disable
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
    -- cspell:enable
  },
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("kmo.mason.install", {}),
  desc = "mason.nvim: Automatically install packages for specific file types.",
  callback = function()
    require("kmo.plugin-management.mason-utils").install_packages(
      pkgs_by_ft[vim.bo.filetype]
    )
  end,
})
