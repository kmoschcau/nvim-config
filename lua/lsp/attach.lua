-- vim: foldmethod=marker
-- cspell:words omnisharp

---@param client vim.lsp.Client | nil the LSP client
---@param bufnr number the buffer number
return function(client, bufnr)
  local common = require "lsp.common"

  local has_omni_ext, omni_ext = pcall(require, "omnisharp_extended")
  has_omni_ext = false

  local has_snacks, snacks = pcall(require, "snacks")
  local snacks_default_options = { jump = { reuse_win = false } }

  local keymap_implementation =
    common.which_keymap_implementation(bufnr, client, has_snacks, has_omni_ext)

  common.log_capabilities(client)

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

  -- textDocument/codeAction
  -- mapped to gra by default
  -- see: |vim.lsp.buf.code_action()|

  -- textDocument/codeLens
  -- see: |lsp-codelens|
  vim.keymap.set("n", "grc", vim.lsp.codelens.run, {
    buffer = bufnr,
    desc = "LSP: Run the code lens in the current line.",
  })
  vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
    desc = "LSP: Update the code lenses of the buffer.",
    group = common.augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.codelens.refresh { bufnr = bufnr }
    end,
  })

  -- textDocument/completion
  -- cspell:disable-next-line
  -- plugin: Saghen/blink.cmp
  -- see: |lsp-completion|

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
  -- also mapped as limited variant by default as <C-]>, <C-w>] and <C-w>}
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

  -- textDocument/diagnostic
  -- cspell:disable-next-line
  -- plugin: mfussenegger/nvim-lint
  -- see: |lsp-diagnostic|
  -- see: |vim.diagnostic|

  -- textDocument/documentColor
  -- cspell:disable-next-line
  -- plugin: brenoprata10/nvim-highlight-colors
  -- see: |lsp-document_color|

  -- textDocument/documentHighlight
  -- cspell:disable-next-line
  -- plugin: RRethy/vim-illuminate
  -- see: |vim.lsp.buf.clear_references()|
  -- see: |vim.lsp.buf.document_highlight()|

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

  -- textDocument/foldingRange
  if common.supports_method(client, "textDocument/foldingRange") then
    vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
    vim.opt_local.foldmethod = "expr"
  end

  -- textDocument/formatting
  -- cspell:disable-next-line
  -- plugin: stevearc/conform.nvim
  -- see: |vim.lsp.buf.format()|

  -- textDocument/hover
  -- mapped to K by default
  -- see: |vim.lsp.buf.hover()|

  -- textDocument/implementation
  -- mapped to gri by default
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

  -- textDocument/inlayHint
  -- see: |lsp-inlay_hint|
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

  -- textDocument/prepareTypeHierarchy
  -- see: |vim.lsp.buf.typehierarchy()|
  vim.keymap.set("n", "<Space>tb", function()
    vim.lsp.buf.typehierarchy "subtypes"
  end, {
    buffer = bufnr,
    desc = "LSP: List all the subtypes of the symbol under the cursor.",
  })
  vim.keymap.set("n", "<Space>tp", function()
    vim.lsp.buf.typehierarchy "supertypes"
  end, {
    buffer = bufnr,
    desc = "LSP: List all the supertypes of the symbol under the cursor.",
  })

  -- textDocument/publishDiagnostics
  -- see: textDocument/diagnostic

  -- textDocument/rangeFormatting
  -- see: textDocument/formatting

  -- textDocument/rangesFormatting
  -- see: textDocument/formatting

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

  -- textDocument/rename
  -- mapped to grn by default
  if client and client.name == "vue_ls" then
    vim.keymap.set(
      "n",
      "<Space>grnv", -- cspell:disable-line
      function()
        vim.lsp.buf.rename(nil, {
          filter = function(c)
            -- TODO: Check filetype and injected language instead and move to grn
            -- keymap.
            return c.name == "vue_ls"
          end,
        })
      end,
      {
        buffer = bufnr,
        desc = "LSP: Rename the symbol under the cursor with vue_ls",
      }
    )
  end

  -- textDocument/selectionRange
  -- mapped in visual to "an" and "in" by default

  -- textDocument/semanticTokens/full
  -- see: |lsp-semantic_tokens|

  -- textDocument/semanticTokens/full/delta
  -- see: textDocument/semanticTokens/full

  -- textDocument/signatureHelp
  -- mapped in insert to <C-s> by default
  -- TODO: Add custom handler for overloads.
  -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/handlers.lua#L411
  -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/util.lua#L720
  vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, {
    buffer = bufnr,
    desc = "LSP: Show signature help.",
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
    vim.keymap.set("n", "grt", type_definition_impl, {
      buffer = bufnr,
      desc = "LSP("
        .. type_definition_impl_desc
        .. "): Find type definitions of the symbol under the cursor.",
    })
  end

  -- typeHierarchy/subtypes
  -- see: textDocument/prepareTypeHierarchy

  -- typeHierarchy/supertypes
  -- see: textDocument/prepareTypeHierarchy

  -- workspace/symbol
  -- cspell:disable-next-line
  -- plugin: folke/snacks.nvim

  -- workspace/workspaceFolders
  -- not used
  -- see: |vim.lsp.buf.add_workspace_folder()|
  -- see: |vim.lsp.buf.list_workspace_folders()|
  -- see: |vim.lsp.buf.remove_workspace_folder()|

  -- textDocument/_vs_onAutoInsert
  require("lsp.common.roslyn").set_up_vs_on_auto_insert_autocmd(client, bufnr)
end
