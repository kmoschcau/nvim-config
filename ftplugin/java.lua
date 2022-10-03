-- vim: foldmethod=marker
-- Java file type settings

-- general Vim settings {{{1
-- Vim options {{{2

-- Maximum width of text that is being inserted. A longer line will be broken
-- after white space to get this width.
vim.api.nvim_buf_set_option(0, "textwidth", 100)

-- plugin configurations {{{1
-- ale | dense-analysis/ale {{{2

-- Set the ALE linters to run for java
vim.api.nvim_buf_set_var(0, "ale_linters", {
  java = { "checkstyle", "pmd" }
})

-- jdtls | mfussenegger/nvim-jdtls {{{2

-- TODO: deduplicate this
local function on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format { async = true }
  end, bufopts)

  local caps = client.server_capabilities

  local augroup = vim.api.nvim_create_augroup("LanguageServer", {
    clear = true
  })
  if caps.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh
    })
  end

  if caps.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
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
    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.semantic_tokens_full
    })
    vim.lsp.buf.semantic_tokens_full()
  end
end

local package = require("mason-registry").get_package("jdtls")
if package:is_installed() then
  local jar = vim.fn.glob(package:get_install_path() .. "/plugins/org.eclipse.equinox.launcher_*.jar")

  local os
  if vim.fn.has("win32") == 1 then
    os = "win"
  else
    os = "linux"
  end
  local config = package:get_install_path() .. "/config_" .. os

  local prj_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
  local workspace = vim.fs.normalize("~/.local/share/" .. prj_name)

  require("jdtls").start_or_attach {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", jar,
      "-configuration", config,
      "-data", workspace
    },
    on_attach = on_attach,
    settings = {
      java = {
        codeGeneration = {
          hashCodeEquals = {
            useInstanceof = true,
            useJava7Objects = true
          },
          toString = {
            codeStyle = "STRING_BUILDER_CHAINED"
          },
          useBlocks = true
        },
        completion = {
          importOrder = {
            "com",
            "java",
            "javassist",
            "javax",
            "org"
          },
          overwrite = false
        },
        configuration = {
          runtimes = {
            {
              name = "JavaSE-1.8",
              path = "/usr/lib/jvm/java-8-openjdk-amd64"
            },
            {
              name = "JavaSE-11",
              path = "/usr/lib/jvm/java-11-openjdk-amd64"
            }
          },
          updateBuildConfiguration = "automatic"
        },
        eclipse = {
          downloadSources = true
        },
        format = {
          settings = {
            url = "~/.config/nvim/coc/eclipse-formatter.xml"
          }
        },
        implementationsCodeLens = {
          enabled = true
        },
        inlayHints = {
          parameterNames = {
            enabled = false
          }
        },
        maven = {
          downloadSources = true
        },
        referencesCodeLens = {
          enabled = true
        },
        signatureHelp = {
          description = {
            enabled = true
          }
        }
      }
    }
  }
end
