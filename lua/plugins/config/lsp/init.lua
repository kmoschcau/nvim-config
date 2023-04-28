local M = {}

local formatting_ignore_list = {
  "omnisharp",
  "tsserver",
}

--- @param name string
--- @return boolean
local function is_ignored_formatter(name)
  return vim.list_contains(formatting_ignore_list, name)
end

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
    local caps = client.server_capabilities

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
      buffer = args.buf,
      desc = "Go to the declaration of the symbol under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "gd", tel_builtin.lsp_definitions, {
      buffer = args.buf,
      desc = "Fuzzy find definitions of the symbol under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "gi", tel_builtin.lsp_implementations, {
      buffer = args.buf,
      desc = "Fuzzy find implementations of the symbol under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {
      buffer = args.buf,
      desc = "Show signature help for parameter under the cursor.",
      silent = true,
    })
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
    vim.keymap.set("n", "<space>D", tel_builtin.lsp_type_definitions, {
      buffer = args.buf,
      desc = "Fuzzy find type definitions of the symbol under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {
      buffer = args.buf,
      desc = "Rename the symbol under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, {
      buffer = args.buf,
      desc = "Trigger the code actions menu for the position under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "gr", tel_builtin.lsp_references, {
      buffer = args.buf,
      desc = "Fuzzy find references of the symbol under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "gci", tel_builtin.lsp_incoming_calls, {
      buffer = args.buf,
      desc = "Fuzzy find incoming calls of the symbol under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "gco", tel_builtin.lsp_outgoing_calls, {
      buffer = args.buf,
      desc = "Fuzzy find outgoing calls of the symbol under the cursor.",
      silent = true,
    })
    vim.keymap.set("n", "<space>sd", tel_builtin.lsp_document_symbols, {
      buffer = args.buf,
      desc = "Fuzzy find document symbols.",
      silent = true,
    })
    vim.keymap.set("n", "<space>sw", tel_builtin.lsp_dynamic_workspace_symbols, {
      buffer = args.buf,
      desc = "Fuzzy find workspace symbols.",
      silent = true,
    })

    if caps.hoverProvider then
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {
        buffer = args.buf,
        desc = "Trigger hover for the symbol under the cursor.",
        silent = true,
      })
    end

    if
      caps.documentFormattingProvider and not is_ignored_formatter(client.name)
    then
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

    if caps.codeLensProvider then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        desc = "Update the code lenses of the buffer.",
        group = augroup,
        buffer = args.buf,
        callback = vim.lsp.codelens.refresh,
      })
    end

    if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
      vim.keymap.set("n", "<F9>", vim.lsp.semantic_tokens.force_refresh, {
        buffer = args.buf,
        desc = "Do a full semantic tokens refresh.",
        silent = true,
      })
    end
  end,
})

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require "lspconfig"

local simple_servers = {
  "cssls",
  "gradle_ls",
  "jedi_language_server",
  "jsonls",
  "lemminx",
  "ruff_lsp",
  "vimls",
  "yamlls",
}
for _, lsp in ipairs(simple_servers) do
  lspconfig[lsp].setup {
    capabilities = M.capabilities,
    handlers = M.handlers,
  }
end

lspconfig.ember.setup {
  capabilities = M.capabilities,
  filetypes = {
    "html.handlebars",
    "handlebars",
  },
  handlers = M.handlers,
}

lspconfig.glint.setup {
  capabilities = M.capabilities,
  filetypes = {
    "html.handlebars",
    "handlebars",
    "typescript.glimmer",
    "javascript.glimmer",
  },
  handlers = M.handlers,
}

lspconfig.html.setup {
  capabilities = M.capabilities,
  filetypes = { "html", "jsp" },
  handlers = M.handlers,
  settings = {
    html = {
      format = {
        indentInnerHtml = true,
        wrapAttributes = "preserve",
        templating = true,
      },
    },
  },
}

lspconfig.lua_ls.setup {
  capabilities = M.capabilities,
  handlers = M.handlers,
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
    },
  },
}

require("typescript").setup {
  server = {
    capabilities = M.capabilities,
    handlers = M.handlers,
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
