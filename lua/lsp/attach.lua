-- vim: set foldmethod=marker

local common = require "lsp.common"

--- @class LspAttachData
--- @field client_id number the number of the LSP client

--- @class LspAttachArgs
--- @field buf number the buffer number
--- @field data LspAttachData the LspAttach specific data

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Set up things when attaching with a language client to a server.",
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
      desc = "Go to the declaration of the symbol under the cursor.",
      silent = true,
    })

    -- textDocument/definition
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
          desc = "Fuzzy find definitions of the symbol under the cursor.",
          silent = true,
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
        desc = "Fuzzy find implementations of the symbol under the cursor.",
        silent = true,
      }
    )

    -- textDocument/signatureHelp
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {
      buffer = args.buf,
      desc = "Show signature help for parameter under the cursor.",
      silent = true,
    })

    -- workspace/didChangeWorkspaceFolders
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, {
      buffer = args.buf,
      desc = "Add a workspace folder.",
      silent = true,
    })
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, {
      buffer = args.buf,
      desc = "Remove a workspace folder.",
      silent = true,
    })

    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {
      buffer = args.buf,
      desc = "Print the current workspace folders.",
      silent = true,
    })

    -- textDocument/typeDefinition
    vim.keymap.set(
      "n",
      "<space>D",
      has_telescope and tel_builtin.lsp_type_definitions
        or vim.lsp.buf.type_definition,
      {
        buffer = args.buf,
        desc = "Fuzzy find type definitions of the symbol under the cursor.",
        silent = true,
      }
    )

    -- textDocument/rename
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {
      buffer = args.buf,
      desc = "Rename the symbol under the cursor.",
      silent = true,
    })

    -- textDocument/codeAction
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, {
      buffer = args.buf,
      desc = "Trigger the code actions menu for the position under the cursor.",
      silent = true,
    })

    -- textDocument/references
    vim.keymap.set(
      "n",
      "gr",
      has_telescope and tel_builtin.lsp_references or vim.lsp.buf.references,
      {
        buffer = args.buf,
        desc = "Fuzzy find references of the symbol under the cursor.",
        silent = true,
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
        desc = "Fuzzy find incoming calls of the symbol under the cursor.",
        silent = true,
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
        desc = "Fuzzy find outgoing calls of the symbol under the cursor.",
        silent = true,
      }
    )

    -- textDocument/documentSymbol
    vim.keymap.set(
      "n",
      "<space>sd",
      has_telescope and tel_builtin.lsp_document_symbols
        or vim.lsp.buf.document_symbol,
      {
        buffer = args.buf,
        desc = "Fuzzy find document symbols.",
        silent = true,
      }
    )

    -- workspace/symbol
    vim.keymap.set(
      "n",
      "<space>sw",
      has_telescope and tel_builtin.lsp_dynamic_workspace_symbols
        or vim.lsp.buf.workspace_symbol,
      {
        buffer = args.buf,
        desc = "Fuzzy find workspace symbols.",
        silent = true,
      }
    )

    -- textDocument/hover
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
      buffer = args.buf,
      desc = "Trigger hover for the symbol under the cursor.",
      silent = true,
    })

    if common.supports_method(client, "textDocument/formatting") then
      if common.is_ignored_formatter(client and client.name) then
        local c = client or { name = "NilClient" }
        vim.notify_once(
          "Ignoring " .. c.name .. " as formatting provider.",
          vim.log.levels.DEBUG
        )
      else
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format {
            async = true,
            filter = function(formatting_client)
              return not common.is_ignored_formatter(formatting_client.name)
            end,
          }
        end, {
          buffer = args.buf,
          desc = "Format the current buffer.",
          silent = true,
        })
      end
    end

    if
      common.supports_method(client, "textDocument/codeLens")
      or common.supports_method(client, "codeLens/resolve")
    then
      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
        desc = "Update the code lenses of the buffer.",
        group = common.augroup,
        buffer = args.buf,
        callback = vim.lsp.codelens.refresh,
      })
    end

    if common.supports_method(client, "textDocument/semanticTokens/full") then
      vim.keymap.set("n", "<F9>", vim.lsp.semantic_tokens.force_refresh, {
        buffer = args.buf,
        desc = "Do a full semantic tokens refresh.",
        silent = true,
      })
    end

    -- inlayHint/resolve
    -- textDocument/inlayHint
    vim.keymap.set("n", "[ih", function()
      vim.lsp.inlay_hint(args.buf, true)
    end, {
      buffer = args.buf,
      desc = "Enable inlay hints in the buffer.",
      silent = true,
    })
    vim.keymap.set("n", "]ih", function()
      vim.lsp.inlay_hint(args.buf, false)
    end, {
      buffer = args.buf,
      desc = "Disable inlay hints in the buffer.",
      silent = true,
    })
    vim.keymap.set("n", "yih", function()
      vim.lsp.inlay_hint(args.buf)
    end, {
      buffer = args.buf,
      desc = "Toggle inlay hints in the buffer.",
      silent = true,
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
