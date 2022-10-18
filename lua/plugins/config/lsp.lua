local M = {}

M.on_attach = function(client, bufnr)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
    buffer = bufnr,
    desc = "Go to the declaration(s) of the symbol under the cursor.",
    silent = true
  })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
    buffer = bufnr,
    desc = "Go to the definition(s) of the symbol under the cursor.",
    silent = true
  })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    buffer = bufnr,
    desc = "Trigger hover for the symbol under the cursor.",
    silent = true
  })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
    buffer = bufnr,
    desc = "Go to the implementation(s) of the symbol under the cursor.",
    silent = true
  })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {
    buffer = bufnr,
    desc = "Show signature help for parameter under the cursor.",
    silent = true
  })
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, {
    buffer = bufnr,
    desc = "Add a workspace folder.",
    silent = true
  })
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, {
    buffer = bufnr,
    desc = "Remove a workspace folder.",
    silent = true
  })
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, {
    buffer = bufnr,
    desc = "Print the current workspace folders.",
    silent = true
  })
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, {
    buffer = bufnr,
    desc = "Go to the type definition(s) of the symbol under the cursor.",
    silent = true
  })
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {
    buffer = bufnr,
    desc = "Rename the symbol under the cursor.",
    silent = true
  })
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, {
    buffer = bufnr,
    desc = "Trigger the code actions menu for the position under the cursor.",
    silent = true
  })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, {
    buffer = bufnr,
    desc = "Go to the reference(s) of the symbol under the cursor.",
    silent = true
  })

  local caps = client.server_capabilities

  if caps.documentFormattingProvider and client.name ~= "tsserver" then
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format {
        async = true,
        filter = function(formatting_client)
          return formatting_client.name ~= "tsserver"
        end
      }
    end, {
      buffer = bufnr,
      desc = "Format the current buffer.",
      silent = true
    })
  end

  local augroup = vim.api.nvim_create_augroup("LanguageServer", {})

  if caps.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      desc = "Update the code lenses of the buffer.",
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh
    })
  end

  if caps.documentHighlightProvider then
    vim.api.nvim_create_autocmd("CursorHold", {
      desc = "Document highlight references of the token under the cursor.",
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "BufLeave" }, {
      desc = "Clear document highlight references.",
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references
    })
  end

  if caps.semanticTokensProvider and caps.semanticTokensProvider.range then
    vim.keymap.set("v", "<F10>", function()
      vim.lsp.buf_request(
        0,
        "textDocument/semanticTokens/range",
        vim.lsp.util.make_given_range_params(),
        vim.lsp.with(require("nvim-semantic-tokens.semantic_tokens").on_full, {
          on_token = function(_, token)
            vim.notify(token.type .. "." .. table.concat(token.modifiers, "."))
          end
        })
      )
    end, {
      buffer = bufnr,
      desc = "Show LSP semantic tokens in selection.",
      silent = true
    })
  end

  if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    vim.keymap.set("n", "<F9>", vim.lsp.buf.semantic_tokens_full, {
      buffer = bufnr,
      desc = "Do a full semantic tokens refresh.",
      silent = true
    })

    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
      desc = "Do a full semantic tokens refresh.",
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

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

local simple_servers = { "jsonls", "vimls" }
for _, lsp in ipairs(simple_servers) do
  lspconfig[lsp].setup {
    capabilities = M.capabilities,
    on_attach = M.on_attach
  }
end

lspconfig.sumneko_lua.setup {
  capabilities = M.capabilities,
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
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    settings = {
      javascript = {
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
