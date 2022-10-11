-- TODO: move this out of here when moving fully to lua
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local M = {}

M.on_attach = function (client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
  vim.keymap.set("n", "<F9>", vim.lsp.buf.semantic_tokens_full, bufopts)

  local caps = client.server_capabilities

  local augroup = vim.api.nvim_create_augroup("LanguageServer", {
    clear = true
  })
  if caps.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh
    })
  end

  if caps.documentHighlightProvider then
    vim.api.nvim_create_autocmd("CursorHold", {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "BufLeave" }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references
    })
  end

  if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.semantic_tokens_full
    })
    vim.lsp.buf.semantic_tokens_full()
  end
end

require("nvim-semantic-tokens").setup {
  preset = "default",
  highlighters = { require "nvim-semantic-tokens.table-highlighter" }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

M.capabilities = capabilities

local lspconfig = require("lspconfig")

local simple_servers = { "jsonls", "vimls" }
for _, lsp in ipairs(simple_servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = M.on_attach
  }
end

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = M.on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Both"
      },
      format = {
        defaultConfig = {
          quote_style = "double"
        }
      },
      telemetry = {
        enable = false
      },
      workspace = {
        -- TODO: This should be only in vim config projects
        library = vim.api.nvim_get_runtime_file("*.lua", true)
      }
    }
  }
}

require("typescript").setup {
  server = {
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      javascript = {
        format = {
          semicolons = "insert"
        },
        preferences = {
          importModuleSpecifier = "relative",
          importModuleSpecifierEnding = "js",
          quoteStyle = "double",
          useAliasesForRenames = false
        },
        referencesCodeLens = {
          enabled = true,
          showOnAllFunctions = true
        },
        suggest = {
          completeFunctionCalls = true
        }
      },
      typescript = {
        format = {
          semicolons = "insert"
        },
        implementationsCodeLens = {
          enabled = true
        },
        preferences = {
          importModuleSpecifier = "relative",
          importModuleSpecifierEnding = "js",
          quoteStyle = "double",
          useAliasesForRenames = false
        },
        referencesCodeLens = {
          enabled = true,
          showOnAllFunctions = true
        },
        suggest = {
          completeFunctionCalls = true
        },
        surveys = {
          enabled = false
        }
      }
    }
  }
}

return M
