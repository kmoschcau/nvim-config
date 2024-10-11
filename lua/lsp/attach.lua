-- vim: foldmethod=marker

--- @param client vim.lsp.Client|nil the LSP client
--- @param bufnr number the buffer number
return function(client, bufnr)
  local common = require "lsp.common"

  local has_omni_ext, omni_ext = pcall(require, "omnisharp_extended")
  local keymap_implementation =
    common.which_keymap_implementation(bufnr, client, has_omni_ext)

  common.log_capabilities(client)

  -- keymaps {{{1

  -- textDocument/declaration
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
    buffer = bufnr,
    desc = "LSP: Go to the declaration of the symbol under the cursor.",
  })

  -- textDocument/definition
  -- (also mapped as limited variant by default as <C-]>, <C-w>] and <C-w>})
  local definition_impl, definition_impl_descr =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.definition,
      { omni_ext_impl = omni_ext.telescope_lsp_definition }
    )
  if definition_impl then
    vim.keymap.set("n", "gd", definition_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. definition_impl_descr
        .. "): Fuzzy find definitions of the symbol under the cursor.",
    })
  end

  -- textDocument/implementation
  local implementation_impl, implementation_impl_descr =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.implementation,
      { omni_ext_impl = omni_ext.telescope_lsp_implementation }
    )
  if implementation_impl then
    vim.keymap.set("n", "gri", implementation_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. implementation_impl_descr
        .. "): Fuzzy find implementations of the symbol under the cursor.",
    })
  end

  -- textDocument/signatureHelp | mapped in insert to <C-s> by default
  vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, {
    buffer = bufnr,
    desc = "LSP: Show signature help.",
  })

  -- workspace/didChangeWorkspaceFolders
  vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, {
    buffer = bufnr,
    desc = "LSP: Add a workspace folder.",
  })
  vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, {
    buffer = bufnr,
    desc = "LSP: Remove a workspace folder.",
  })

  vim.keymap.set("n", "<Space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, {
    buffer = bufnr,
    desc = "LSP: Print the current workspace folders.",
  })

  -- textDocument/typeDefinition
  local type_definition_impl, type_definition_impl_descr =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.type_definition,
      { omni_ext_impl = omni_ext.telescope_lsp_type_definition }
    )
  if type_definition_impl then
    vim.keymap.set("n", "<Space>D", type_definition_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. type_definition_impl_descr
        .. "): Fuzzy find type definitions of the symbol under the cursor.",
    })
  end

  -- textDocument/rename | mapped to grn by default

  -- textDocument/codeAction | mapped to gra by default

  -- textDocument/references | mapped to grr by default
  local references_impl, references_impl_descr =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.references,
      { omni_ext_impl = omni_ext.telescope_lsp_references }
    )
  if references_impl then
    vim.keymap.set("n", "grr", references_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. references_impl_descr
        .. "): Fuzzy find references for the symbol under the cursor.",
    })
  end

  -- callHierarchy/incomingCalls
  vim.keymap.set("n", "<Space>ci", vim.lsp.buf.incoming_calls, {
    buffer = bufnr,
    desc = "LSP: Fuzzy find incoming calls of the symbol under the cursor.",
  })

  -- callHierarchy/outgoingCalls
  vim.keymap.set("n", "<Space>co", vim.lsp.buf.outgoing_calls, {
    buffer = bufnr,
    desc = "LSP: Fuzzy find outgoing calls of the symbol under the cursor.",
  })

  -- textDocument/documentSymbol
  vim.keymap.set("n", "<Space>sd", vim.lsp.buf.document_symbol, {
    buffer = bufnr,
    desc = "LSP: Fuzzy find document symbols.",
  })

  -- workspace/symbol
  vim.keymap.set("n", "<Space>sw", vim.lsp.buf.workspace_symbol, {
    buffer = bufnr,
    desc = "LSP: Fuzzy find workspace symbols.",
  })

  -- textDocument/hover | mapped to K by default

  -- textDocument/formatting | see conform plugin

  -- textDocument/rangeFormatting | see conform plugin

  -- textDocument/semanticTokens/full
  vim.keymap.set("n", "<F9>", vim.lsp.semantic_tokens.force_refresh, {
    buffer = bufnr,
    desc = "LSP: Do a full semantic tokens refresh.",
  })

  -- inlayHint/resolve
  -- textDocument/inlayHint
  vim.keymap.set("n", "[ih", function()
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end, {
    buffer = bufnr,
    desc = "LSP: Enable inlay hints in the buffer.",
  })
  vim.keymap.set("n", "]ih", function()
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end, {
    buffer = bufnr,
    desc = "LSP: Disable inlay hints in the buffer.",
  })
  vim.keymap.set("n", "yih", function()
    vim.lsp.inlay_hint.enable(
      not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr },
      { bufnr = bufnr }
    )
  end, {
    buffer = bufnr,
    desc = "LSP: Toggle inlay hints in the buffer.",
  })

  -- }}}

  -- autocommands {{{

  if
    common.supports_method(client, "textDocument/codeLens")
    or common.supports_method(client, "codeLens/resolve")
  then
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      desc = "LSP: Update the code lenses of the buffer.",
      group = common.augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh { bufnr = bufnr }
      end,
    })
  end

  -- }}}

  -- plugin hooks {{{

  if common.supports_method(client, "textDocument/documentSymbol") then
    local c = client or { name = "NilClient" }

    local has_navic, navic = pcall(require, "nvim-navic")
    if has_navic then
      navic.attach(client, bufnr)

      vim.notify("Attached navic to: " .. c.name, vim.log.levels.DEBUG)
    end
  end

  -- }}}
end
