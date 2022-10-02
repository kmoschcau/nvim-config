local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)

  local caps = client.server_capabilities

  if caps.documentHighlightProvider then
    local augroup =
      vim.api.nvim_create_augroup("DocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references
    })
  end

  if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    local augroup =
      vim.api.nvim_create_augroup("SemanticTokens", { clear = true})
    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
      group = augroup,
      buffer = bufnr,
      callback = function() vim.lsp.buf.semantic_tokens_full() end
    })
    vim.lsp.buf.semantic_tokens_full()
  end
end

require 'nvim-semantic-tokens'.setup {
  preset = 'default',
  highlighters = { require 'nvim-semantic-tokens.table-highlighter' }
}

require 'lspconfig'.jsonls.setup {}

require 'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = {
        enable = false
      }
    }
  }
}

require 'lspconfig'.tsserver.setup {
  on_attach = on_attach
}

require 'lspconfig'.vimls.setup {
  on_attach = on_attach
}
