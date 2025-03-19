-- vim: foldmethod=marker

--- @param client vim.lsp.Client|nil the LSP client
--- @param bufnr number the buffer number
return function(client, bufnr)
  local common = require "lsp.common"

  local has_omni_ext, omni_ext = pcall(require, "omnisharp_extended")
  has_omni_ext = false

  local has_snacks, snacks = pcall(require, "snacks")
  local snacks_default_options = { jump = { reuse_win = false } }

  local keymap_implementation =
    common.which_keymap_implementation(bufnr, client, has_snacks, has_omni_ext)

  common.log_capabilities(client)

  -- keymaps {{{

  -- textDocument/declaration
  local declaration_impl, declaration_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.declaration,
      {
        snacks_impl = common.with_options(
          snacks.picker.lsp_declarations,
          snacks_default_options
        ),
      }
    )
  if declaration_impl then
    vim.keymap.set("n", "gD", declaration_impl, {
      buffer = bufnr,
      desc = "LSP"
        .. declaration_impl_desc
        .. ": Go to the declaration of the symbol under the cursor.",
    })
  end

  -- textDocument/definition
  -- (also mapped as limited variant by default as <C-]>, <C-w>] and <C-w>})
  local definition_impl, definition_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.definition,
      {
        omni_ext_impl = omni_ext.lsp_definition,
        snacks_impl = common.with_options(
          snacks.picker.lsp_definitions,
          snacks_default_options
        ),
      }
    )
  if definition_impl then
    vim.keymap.set("n", "gd", definition_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. definition_impl_desc
        .. "): Find definitions of the symbol under the cursor.",
    })
  end

  -- textDocument/implementation | mapped to gri by default
  local implementation_impl, implementation_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.implementation,
      {
        omni_ext_impl = omni_ext.lsp_implementation,
        snacks_impl = common.with_options(
          snacks.picker.lsp_implementations,
          snacks_default_options
        ),
      }
    )
  if implementation_impl then
    vim.keymap.set("n", "gri", implementation_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. implementation_impl_desc
        .. "): Find implementations of the symbol under the cursor.",
    })
  end

  -- textDocument/signatureHelp | mapped in insert to <C-s> by default
  vim.keymap.set({ "n", "i" }, "<C-s>", function()
    vim.lsp.buf.signature_help { border = "rounded" } -- TODO: winborder
  end, {
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
  local type_definition_impl, type_definition_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.type_definition,
      {
        omni_ext_impl = omni_ext.lsp_type_definition,
        snacks_impl = common.with_options(
          snacks.picker.lsp_type_definitions,
          snacks_default_options
        ),
      }
    )
  if type_definition_impl then
    vim.keymap.set("n", "<Space>D", type_definition_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. type_definition_impl_desc
        .. "): Find type definitions of the symbol under the cursor.",
    })
  end

  -- textDocument/rename | mapped to grn by default
  if client and client.name == "volar" then
    vim.keymap.set("n", "<Space>grnv", function()
      vim.lsp.buf.rename(nil, {
        filter = function(c)
          -- TODO: Check filetype and injected language instead and move to grn
          -- keymap.
          return c.name == "volar"
        end,
      })
    end, {
      buffer = bufnr,
      desc = "LSP: Rename the symbol under the cursor with volar",
    })
  end

  -- textDocument/codeAction | mapped to gra by default

  -- textDocument/codeLens
  if common.supports_method(client, "codeLens/resolve") then
    vim.keymap.set("n", "grc", vim.lsp.codelens.run, {
      buffer = bufnr,
      desc = "LSP: Run the code lens in the current line.",
    })
  end

  -- textDocument/references | mapped to grr by default
  local references_impl, references_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.references,
      {
        omni_ext_impl = omni_ext.lsp_references,
        snacks_impl = common.with_options(
          snacks.picker.lsp_references,
          vim.tbl_deep_extend("force", snacks_default_options, {
            include_declaration = false,
          })
        ),
      }
    )
  if references_impl then
    vim.keymap.set("n", "grr", references_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. references_impl_desc
        .. "): Find references for the symbol under the cursor.",
    })
  end

  -- callHierarchy/incomingCalls
  local incoming_calls_impl, incoming_calls_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.incoming_calls,
      {}
    )
  if incoming_calls_impl then
    vim.keymap.set("n", "<Space>ci", incoming_calls_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. incoming_calls_impl_desc
        .. "): Find incoming calls of the symbol under the cursor.",
    })
  end

  -- callHierarchy/outgoingCalls
  local outgoing_calls_impl, outgoing_calls_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.outgoing_calls,
      {}
    )
  if outgoing_calls_impl then
    vim.keymap.set("n", "<Space>co", outgoing_calls_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. outgoing_calls_impl_desc
        .. "): Find outgoing calls of the symbol under the cursor.",
    })
  end

  -- textDocument/documentSymbol | mapped to gO by default
  local document_symbol_impl, document_symbol_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.document_symbol,
      { snacks_impl = snacks.picker.lsp_symbols }
    )
  if document_symbol_impl then
    vim.keymap.set("n", "gO", document_symbol_impl, {
      buffer = bufnr,
      desc = "LSP(" .. document_symbol_impl_desc .. "): Find document symbols.",
    })
  end

  -- workspace/symbol
  local workspace_symbol_impl, workspace_symbol_impl_desc =
    common.choose_keymap_implementation(
      keymap_implementation,
      vim.lsp.buf.workspace_symbol,
      { snacks_impl = snacks.picker.lsp_workspace_symbols }
    )
  if workspace_symbol_impl then
    vim.keymap.set("n", "<Space>sw", workspace_symbol_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. workspace_symbol_impl_desc
        .. "): Find workspace symbols.",
    })
  end

  -- textDocument/hover | mapped to K by default
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover { border = "rounded" } -- TODO: winborder
  end, {
    buffer = bufnr,
    desc = "LSP: Display hover information about the symbol under the cursor"
      .. " in a floating window.",
  })

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

  -- settings {{{

  if common.supports_method(client, "textDocument/foldingRange") then
    vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
    vim.opt_local.foldtext = "v:lua.vim.lsp.foldtext()"
  end

  -- }}}

  -- autocommands {{{

  if common.supports_method(client, "textDocument/codeLens") then
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      desc = "LSP: Update the code lenses of the buffer.",
      group = common.augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh { bufnr = bufnr }
      end,
    })
  end
end
