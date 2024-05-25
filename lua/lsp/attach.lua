-- vim: set foldmethod=marker

local common = require "lsp.common"

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
    local has_telescope, tel_builtin = pcall(require, "telescope.builtin")

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    common.log_capabilities(client)

    -- keymaps {{{1
    -- textDocument/declaration
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
      buffer = args.buf,
      desc = "LSP: Go to the declaration of the symbol under the cursor.",
    })

    -- textDocument/definition
    -- (also mapped as limited variant by default as <C-]>, <C-w>] and <C-w>})
    if client and client.name ~= "omnisharp" then
      vim.keymap.set(
        "n",
        "gd",
        common.supports_method(client, "textDocument/definition")
            and has_telescope
            and tel_builtin.lsp_definitions
          or vim.lsp.buf.definition,
        {
          buffer = args.buf,
          desc = "LSP: Fuzzy find definitions of the symbol under the cursor.",
        }
      )
    end

    -- textDocument/implementation
    vim.keymap.set(
      "n",
      "gi",
      common.supports_method(client, "textDocument/implementation")
          and has_telescope
          and tel_builtin.lsp_implementations
        or vim.lsp.buf.implementation,
      {
        buffer = args.buf,
        desc = "LSP: Fuzzy find implementations of the symbol under the cursor.",
      }
    )

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
    vim.keymap.set(
      "n",
      "<Space>D",
      has_telescope and tel_builtin.lsp_type_definitions
        or vim.lsp.buf.type_definition,
      {
        buffer = args.buf,
        desc = "LSP: Fuzzy find type definitions of the symbol under the cursor.",
      }
    )

    -- textDocument/rename | mapped to grn by default

    -- textDocument/codeAction | mapped to gra by default

    -- textDocument/references (also mapped by default without telescope)
    vim.keymap.set(
      "n",
      "grr",
      has_telescope and tel_builtin.lsp_references or vim.lsp.buf.references,
      {
        buffer = args.buf,
        desc = "LSP: Fuzzy find references of the symbol under the cursor.",
      }
    )

    -- callHierarchy/incomingCalls
    vim.keymap.set(
      "n",
      "gci",
      has_telescope and tel_builtin.lsp_incoming_calls
        or vim.lsp.buf.incoming_calls,
      {
        buffer = args.buf,
        desc = "LSP: Fuzzy find incoming calls of the symbol under the cursor.",
      }
    )

    -- callHierarchy/outgoingCalls
    vim.keymap.set(
      "n",
      "gco",
      has_telescope and tel_builtin.lsp_outgoing_calls
        or vim.lsp.buf.outgoing_calls,
      {
        buffer = args.buf,
        desc = "LSP: Fuzzy find outgoing calls of the symbol under the cursor.",
      }
    )

    -- textDocument/documentSymbol
    vim.keymap.set(
      "n",
      "<Space>sd",
      has_telescope and tel_builtin.lsp_document_symbols
        or vim.lsp.buf.document_symbol,
      {
        buffer = args.buf,
        desc = "LSP: Fuzzy find document symbols.",
      }
    )

    -- workspace/symbol
    vim.keymap.set(
      "n",
      "<Space>sw",
      has_telescope and tel_builtin.lsp_dynamic_workspace_symbols
        or vim.lsp.buf.workspace_symbol,
      {
        buffer = args.buf,
        desc = "LSP: Fuzzy find workspace symbols.",
      }
    )

    -- textDocument/hover
    -- (mapped by default as K, explicit here because of hover.nvim)
    if common.supports_method(client, "textDocument/hover") then
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {
        buffer = args.buf,
        desc = "LSP: Hover.",
      })
    end

    if common.supports_method(client, "textDocument/formatting") then
      if common.is_ignored_formatter(client and client.name) then
        local c = client or { name = "NilClient" }
        vim.notify_once(
          "Ignoring " .. c.name .. " as formatting provider.",
          vim.log.levels.DEBUG
        )
      else
        local format = function()
          vim.lsp.buf.format {
            async = true,
            filter = function(formatting_client)
              return not common.is_ignored_formatter(formatting_client.name)
            end,
          }
        end

        vim.keymap.set("n", "<Space>f", format, {
          buffer = args.buf,
          desc = "LSP: Format the current buffer.",
        })

        if common.supports_method(client, "textDocument/rangeFormatting") then
          vim.keymap.set("x", "<Space>f", format, {
            buffer = args.buf,
            desc = "LSP: Format the selected range.",
          })
        end
      end
    end

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

    if common.supports_method(client, "textDocument/semanticTokens/full") then
      vim.keymap.set("n", "<F9>", vim.lsp.semantic_tokens.force_refresh, {
        buffer = args.buf,
        desc = "LSP: Do a full semantic tokens refresh.",
      })
    end

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
