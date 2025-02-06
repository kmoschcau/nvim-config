--- @param client vim.lsp.Client the LSP client
local function monkey_patch_semantic_tokens(client)
  -- NOTE: Super hacky... Don't know if I like that we set a random variable on
  -- the client Seems to work though ~seblj
  if client.is_hacked then
    return
  end
  client.is_hacked = true

  -- let the runtime know the server can do semanticTokens/full now
  client.server_capabilities =
    vim.tbl_deep_extend("force", client.server_capabilities, {
      semanticTokensProvider = {
        full = true,
      },
    })

  -- monkey patch the request proxy
  local request_inner = client.request
  function client:request(method, params, handler, req_bufnr)
    if method ~= vim.lsp.protocol.Methods.textDocument_semanticTokens_full then
      return request_inner(self, method, params, handler)
    end

    local target_bufnr = vim.uri_to_bufnr(params.textDocument.uri)
    local line_count = vim.api.nvim_buf_line_count(target_bufnr)
    local last_line = vim.api.nvim_buf_get_lines(
      target_bufnr,
      line_count - 1,
      line_count,
      true
    )[1]

    return request_inner(self, "textDocument/semanticTokens/range", {
      textDocument = params.textDocument,
      range = {
        ["start"] = {
          line = 0,
          character = 0,
        },
        ["end"] = {
          line = line_count - 1,
          character = string.len(last_line) - 1,
        },
      },
    }, handler, req_bufnr)
  end
end

local mason_registry = require "mason-registry"

--- @type string[]
local args = {
  "--stdio",
  "--logLevel=Information",
  "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
}

local rzls_package = mason_registry.get_package "rzls"
if rzls_package:is_installed() then
  local rzls_path = vim.fs.joinpath(rzls_package:get_install_path(), "libexec")
  table.insert(
    args,
    "--razorSourceGenerator="
      .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll")
  )
  table.insert(
    args,
    "--razorDesignTimePath="
      .. vim.fs.joinpath(
        rzls_path,
        "Targets",
        "Microsoft.NET.Sdk.Razor.DesignTime.targets"
      )
  )
end

--- @type RoslynNvimConfig
local config = {
  args = args,
  config = {
    capabilities = require("lsp.common").capabilities,
    handlers = require "rzls.roslyn_handlers",
    on_attach = function(client, bufnr)
      require "lsp.attach"(client, bufnr)

      monkey_patch_semantic_tokens(client)
    end,
  },
  filewatching = false,
}

local roslyn_package = mason_registry.get_package "roslyn"
if roslyn_package:is_installed() then
  config.exe = {
    "dotnet",
    vim.fs.joinpath(
      roslyn_package:get_install_path(),
      "libexec",
      "Microsoft.CodeAnalysis.LanguageServer.dll"
    ),
  }
end

require("roslyn").setup(config)
