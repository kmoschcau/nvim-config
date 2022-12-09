-- vim: foldmethod=marker
-- Java file type settings

-- general Neovim settings {{{1
-- Neovim options {{{2

vim.opt_local.textwidth = 100

-- plugin configurations {{{1
-- jdtls | mfussenegger/nvim-jdtls {{{2

local lsp = require "plugins.config.lsp"

local package = require("mason-registry").get_package "jdtls"
if package:is_installed() then
  local jar = vim.fn.glob(
    package:get_install_path() .. "/plugins/org.eclipse.equinox.launcher_*.jar"
  )

  local os
  if vim.fn.has "win32" == 1 then
    os = "win"
  else
    os = "linux"
  end
  local config = package:get_install_path() .. "/config_" .. os

  local prj_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
  local workspace = vim.fs.normalize("~/.local/share/jdt-ws/" .. prj_name)

  require("jdtls").start_or_attach {
    capabilities = require("plugins.config.lsp").capabilities,
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1G",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      jar,
      "-configuration",
      config,
      "-data",
      workspace,
    },
    handlers = lsp.handlers,
    on_attach = lsp.on_attach,
    settings = {
      java = {
        codeGeneration = {
          hashCodeEquals = {
            useInstanceof = true,
            useJava7Objects = true,
          },
          toString = {
            codeStyle = "STRING_BUILDER_CHAINED",
          },
          useBlocks = true,
        },
        completion = {
          importOrder = {
            "com",
            "java",
            "javassist",
            "javax",
            "org",
          },
          overwrite = false,
        },
        configuration = {
          runtimes = {
            {
              name = "JavaSE-1.8",
              path = "/usr/lib/jvm/java-8-openjdk-amd64",
            },
            {
              name = "JavaSE-11",
              path = "/usr/lib/jvm/java-11-openjdk-amd64",
            },
          },
          updateBuildConfiguration = "automatic",
        },
        eclipse = {
          downloadSources = true,
        },
        format = {
          enabled = false,
          settings = {
            url = "~/.config/nvim/eclipse-formatter.xml",
          },
        },
        implementationsCodeLens = {
          enabled = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = false,
          },
        },
        maven = {
          downloadSources = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        signatureHelp = {
          description = {
            enabled = true,
          },
        },
      },
    },
  }
end
