local common = require "plugins.config.lsp.common"
local lspconfig = require "lspconfig"

local simple_servers = {
  "gradle_ls",
  "jedi_language_server",
  "jsonls",
  "lemminx",
  "ruff_lsp",
  "vimls",
}
for _, lsp in ipairs(simple_servers) do
  lspconfig[lsp].setup {
    capabilities = common.capabilities,
    handlers = common.handlers,
  }
end

local server_config_modules = {
  "cssls",
  "ember",
  "glint",
  "html",
  "lua_ls",
  "omnisharp",
  "typescript",
  "yamlls",
}
for _, module_name in ipairs(server_config_modules) do
  require("plugins.config.lsp." .. module_name)
end

-- This is a list of servers that do not have an option to disable formatting.
local formatting_ignore_list = {
  "html",
  "jsonls",
  "omnisharp",
  "tsserver",
}

--- @param name string
--- @return boolean
local function is_ignored_formatter(name)
  local contains = vim.list_contains or vim.tbl_contains
  return contains(formatting_ignore_list, name)
end

--- @class LspAttachData
--- @field client_id number the number of the LSP client

--- @class LspAttachArgs
--- @field buf number the buffer number
--- @field data LspAttachData the LspAttach specific data

local augroup = vim.api.nvim_create_augroup("LanguageServer_InitVim", {})
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Set up things when attaching with a language client to a server.",
  group = augroup,
  --- @param args LspAttachArgs the autocmd args
  callback = function(args)
    local tel_builtin = require "telescope.builtin"

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    common.log_capabilities(client)

    -- textDocument/declaration
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
      buffer = args.buf,
      desc = "Go to the declaration of the symbol under the cursor.",
      silent = true,
    })

    -- textDocument/definition
    vim.keymap.set(
      "n",
      "gd",
      common.supports_method(client, "textDocument/definition")
          and tel_builtin.lsp_definitions
        or vim.lsp.buf.definition,
      {
        buffer = args.buf,
        desc = "Fuzzy find definitions of the symbol under the cursor.",
        silent = true,
      }
    )

    -- textDocument/implementation
    vim.keymap.set(
      "n",
      "gi",
      common.supports_method(client, "textDocument/implementation")
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
    vim.keymap.set("n", "<space>D", tel_builtin.lsp_type_definitions, {
      buffer = args.buf,
      desc = "Fuzzy find type definitions of the symbol under the cursor.",
      silent = true,
    })

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
    vim.keymap.set("n", "gr", tel_builtin.lsp_references, {
      buffer = args.buf,
      desc = "Fuzzy find references of the symbol under the cursor.",
      silent = true,
    })

    -- callHierarchy/incomingCalls
    vim.keymap.set("n", "gci", tel_builtin.lsp_incoming_calls, {
      buffer = args.buf,
      desc = "Fuzzy find incoming calls of the symbol under the cursor.",
      silent = true,
    })

    -- callHierarchy/outgoingCalls
    vim.keymap.set("n", "gco", tel_builtin.lsp_outgoing_calls, {
      buffer = args.buf,
      desc = "Fuzzy find outgoing calls of the symbol under the cursor.",
      silent = true,
    })

    -- textDocument/documentSymbol
    vim.keymap.set("n", "<space>sd", tel_builtin.lsp_document_symbols, {
      buffer = args.buf,
      desc = "Fuzzy find document symbols.",
      silent = true,
    })

    -- workspace/symbol
    vim.keymap.set(
      "n",
      "<space>sw",
      tel_builtin.lsp_dynamic_workspace_symbols,
      {
        buffer = args.buf,
        desc = "Fuzzy find workspace symbols.",
        silent = true,
      }
    )

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
      buffer = args.buf,
      desc = "Trigger hover for the symbol under the cursor.",
      silent = true,
    })

    if common.supports_method(client, "textDocument/formatting") then
      if is_ignored_formatter(client.name) then
        vim.notify_once(
          "Ignoring " .. client.name .. " as formatting provider.",
          vim.log.levels.DEBUG
        )
      else
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format {
            async = true,
            filter = function(formatting_client)
              return not is_ignored_formatter(formatting_client.name)
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
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        desc = "Update the code lenses of the buffer.",
        group = augroup,
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
  end,
})
