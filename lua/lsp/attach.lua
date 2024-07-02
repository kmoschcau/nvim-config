-- vim: set foldmethod=marker

local common = require "lsp.common"

local format = function()
  vim.lsp.buf.format {
    async = true,
    filter = function(formatting_client)
      if common.is_ignored_formatter(formatting_client.name) then
        vim.notify_once(
          "Ignoring " .. formatting_client.name .. " as formatting provider.",
          vim.log.levels.DEBUG
        )
        return false
      else
        return true
      end
    end,
  }
end

--- @class LspAttachData
--- @field client_id number the number of the LSP client

--- @class LspAttachArgs
--- @field buf number the buffer number
--- @field data LspAttachData the LspAttach specific data

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP: Set up things when attaching with a language client to a server.",
  group = common.augroup,
  --- @param args LspAttachArgs the autocmd args
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local has_omni_ext, omni_ext = pcall(require, "omnisharp_extended")
    local keymap_implementation =
      common.which_keymap_implementation(args.buf, client, has_omni_ext)

    common.log_capabilities(client)

    -- keymaps {{{1

    -- textDocument/declaration
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
      buffer = args.buf,
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
        buffer = args.buf,
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
      vim.keymap.set("n", "gi", implementation_impl, {
        buffer = args.buf,
        desc = "LSP("
          .. implementation_impl_descr
          .. "): Fuzzy find implementations of the symbol under the cursor.",
      })
    end

    -- textDocument/signatureHelp | mapped to <C-s> by default

    -- workspace/didChangeWorkspaceFolders
    vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, {
      buffer = args.buf,
      desc = "LSP: Add a workspace folder.",
    })
    vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, {
      buffer = args.buf,
      desc = "LSP: Remove a workspace folder.",
    })

    vim.keymap.set("n", "<Space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {
      buffer = args.buf,
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
        buffer = args.buf,
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
        buffer = args.buf,
        desc = "LSP("
          .. references_impl_descr
          .. "): Fuzzy find references for the symbol under the cursor.",
      })
    end

    -- callHierarchy/incomingCalls
    vim.keymap.set("n", "<Space>ci", vim.lsp.buf.incoming_calls, {
      buffer = args.buf,
      desc = "LSP: Fuzzy find incoming calls of the symbol under the cursor.",
    })

    -- callHierarchy/outgoingCalls
    vim.keymap.set("n", "<Space>co", vim.lsp.buf.outgoing_calls, {
      buffer = args.buf,
      desc = "LSP: Fuzzy find outgoing calls of the symbol under the cursor.",
    })

    -- textDocument/documentSymbol
    vim.keymap.set("n", "<Space>sd", vim.lsp.buf.document_symbol, {
      buffer = args.buf,
      desc = "LSP: Fuzzy find document symbols.",
    })

    -- workspace/symbol
    vim.keymap.set("n", "<Space>sw", vim.lsp.buf.workspace_symbol, {
      buffer = args.buf,
      desc = "LSP: Fuzzy find workspace symbols.",
    })

    -- textDocument/hover | mapped to K by default

    local format_impl, format_impl_descr =
      common.choose_keymap_implementation(keymap_implementation, format)
    if format_impl then
      -- textDocument/formatting
      vim.keymap.set("n", "<Space>f", format_impl, {
        buffer = args.buf,
        desc = "LSP(" .. format_impl_descr .. "): Format the current buffer.",
      })

      -- textDocument/rangeFormatting
      vim.keymap.set("x", "<Space>f", format_impl, {
        buffer = args.buf,
        desc = "LSP(" .. format_impl_descr .. "): Format the selected range.",
      })
    end

    -- textDocument/semanticTokens/full
    vim.keymap.set("n", "<F9>", vim.lsp.semantic_tokens.force_refresh, {
      buffer = args.buf,
      desc = "LSP: Do a full semantic tokens refresh.",
    })

    -- inlayHint/resolve
    -- textDocument/inlayHint
    vim.keymap.set("n", "[ih", function()
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end, {
      buffer = args.buf,
      desc = "LSP: Enable inlay hints in the buffer.",
    })
    vim.keymap.set("n", "]ih", function()
      vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
    end, {
      buffer = args.buf,
      desc = "LSP: Disable inlay hints in the buffer.",
    })
    vim.keymap.set("n", "yih", function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf },
        { bufnr = args.buf }
      )
    end, {
      buffer = args.buf,
      desc = "LSP: Toggle inlay hints in the buffer.",
    })

    -- autocommands {{{1

    if
      common.supports_method(client, "textDocument/codeLens")
      or common.supports_method(client, "codeLens/resolve")
    then
      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
        desc = "LSP: Update the code lenses of the buffer.",
        group = common.augroup,
        buffer = args.buf,
        callback = vim.lsp.codelens.refresh,
      })
    end

    -- plugin hooks {{{1

    if common.supports_method(client, "textDocument/documentSymbol") then
      local c = client or { name = "NilClient" }

      local has_navic, navic = pcall(require, "nvim-navic")
      if has_navic then
        navic.attach(client, args.buf)

        vim.notify("Attached navic to: " .. c.name, vim.log.levels.DEBUG)
      end
    end

    -- }}}1
  end,
})
