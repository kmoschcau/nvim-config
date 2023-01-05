local M = {}

--- Overridden handlers for the LSP client.
M.handlers = {
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded" }
  ),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded" }
  ),
}

--- On attach callback for the LSP client.
--- @param client table the LSP client
--- @param bufnr number the number of the buffer
--- @return nil
M.on_attach = function(client, bufnr)
  local tel_builtin = require "telescope.builtin"

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
    buffer = bufnr,
    desc = "Go to the declaration of the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "gd", tel_builtin.lsp_definitions, {
    buffer = bufnr,
    desc = "Fuzzy find definitions of the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    buffer = bufnr,
    desc = "Trigger hover for the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "gi", tel_builtin.lsp_implementations, {
    buffer = bufnr,
    desc = "Fuzzy find implementations of the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {
    buffer = bufnr,
    desc = "Show signature help for parameter under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, {
    buffer = bufnr,
    desc = "Add a workspace folder.",
    silent = true,
  })
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, {
    buffer = bufnr,
    desc = "Remove a workspace folder.",
    silent = true,
  })
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, {
    buffer = bufnr,
    desc = "Print the current workspace folders.",
    silent = true,
  })
  vim.keymap.set("n", "<space>D", tel_builtin.lsp_type_definitions, {
    buffer = bufnr,
    desc = "Fuzzy find type definitions of the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {
    buffer = bufnr,
    desc = "Rename the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "<space>ca", function()
    vim.cmd [[CodeActionMenu]]
  end, {
    buffer = bufnr,
    desc = "Trigger the code actions menu for the position under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "gr", tel_builtin.lsp_references, {
    buffer = bufnr,
    desc = "Fuzzy find references of the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "gci", tel_builtin.lsp_incoming_calls, {
    buffer = bufnr,
    desc = "Fuzzy find incoming calls of the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "gco", tel_builtin.lsp_outgoing_calls, {
    buffer = bufnr,
    desc = "Fuzzy find outgoing calls of the symbol under the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "<space>sd", tel_builtin.lsp_document_symbols, {
    buffer = bufnr,
    desc = "Fuzzy find document symbols.",
    silent = true,
  })
  vim.keymap.set("n", "<space>sw", tel_builtin.lsp_workspace_symbols, {
    buffer = bufnr,
    desc = "Fuzzy find workspace symbols.",
    silent = true,
  })

  local caps = client.server_capabilities

  if caps.documentFormattingProvider and client.name ~= "tsserver" then
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format {
        async = true,
        filter = function(formatting_client)
          return formatting_client.name ~= "tsserver"
        end,
      }
    end, {
      buffer = bufnr,
      desc = "Format the current buffer.",
      silent = true,
    })
  end

  local augroup = vim.api.nvim_create_augroup("LanguageServer", {})

  if caps.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      desc = "Update the code lenses of the buffer.",
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })

    vim.keymap.set("n", "<F8>", vim.lsp.codelens.refresh, {
      buffer = bufnr,
      desc = "Do a codelens refresh.",
      silent = true,
    })
  end

  if caps.documentHighlightProvider then
    vim.api.nvim_create_autocmd("CursorHold", {
      desc = "Document highlight references of the token under the cursor.",
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "BufLeave" }, {
      desc = "Clear document highlight references.",
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })

    vim.keymap.set("n", "<space>dh", function()
      vim.lsp.buf.clear_references()
      vim.lsp.buf.document_highlight()
    end, {
      buffer = bufnr,
      desc = "Trigger document highlight for the symbol under the cursor.",
      silent = true,
    })

    vim.keymap.set("n", "<space>cr", vim.lsp.buf.clear_references, {
      buffer = bufnr,
      desc = "Clear references (document highlight) in the document.",
      silent = true,
    })
  end

  if caps.semanticTokensProvider and caps.semanticTokensProvider then
    vim.keymap.set("n", "<F9>", vim.lsp.semantic_tokens.force_refresh, {
      buffer = bufnr,
      desc = "Do a full semantic tokens refresh.",
      silent = true,
    })
  end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require "lspconfig"

local simple_servers = { "jsonls", "jedi_language_server", "ruff_lsp", "vimls" }
for _, lsp in ipairs(simple_servers) do
  lspconfig[lsp].setup {
    capabilities = M.capabilities,
    handlers = M.handlers,
    on_attach = M.on_attach,
  }
end

lspconfig.sumneko_lua.setup {
  capabilities = M.capabilities,
  handlers = M.handlers,
  on_attach = M.on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Both",
      },
      format = {
        enable = false,
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        -- TODO: This should be only in vim config projects
        library = vim.api.nvim_get_runtime_file("*.lua", true),
      },
    },
  },
}

require("typescript").setup {
  server = {
    capabilities = M.capabilities,
    handlers = M.handlers,
    on_attach = M.on_attach,
    settings = {
      javascript = {
        preferences = {
          importModuleSpecifier = "relative",
          importModuleSpecifierEnding = "js",
          quoteStyle = "double",
          useAliasesForRenames = false,
        },
        referencesCodeLens = {
          enabled = true,
          showOnAllFunctions = true,
        },
        suggest = {
          completeFunctionCalls = true,
        },
      },
      typescript = {
        implementationsCodeLens = {
          enabled = true,
        },
        preferences = {
          importModuleSpecifier = "relative",
          importModuleSpecifierEnding = "js",
          quoteStyle = "double",
          useAliasesForRenames = false,
        },
        referencesCodeLens = {
          enabled = true,
          showOnAllFunctions = true,
        },
        suggest = {
          completeFunctionCalls = true,
        },
        surveys = {
          enabled = false,
        },
      },
    },
  },
}

return M
