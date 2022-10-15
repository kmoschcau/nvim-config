-- vim: foldmethod=marker
-- Java file type settings

-- general Vim settings {{{1
-- Vim options {{{2

vim.opt_local.textwidth = 100

-- plugin configurations {{{1
-- ale | dense-analysis/ale {{{2

-- FIXME: Need to reimplement these myself with null-ls
vim.b.ale_linters = { java = { "checkstyle", "pmd" } }

-- jdtls | mfussenegger/nvim-jdtls {{{2

local package = require("mason-registry").get_package("jdtls")
if package:is_installed() then
  local jar = vim.fn.glob(package:get_install_path() ..
    "/plugins/org.eclipse.equinox.launcher_*.jar")

  local os
  if vim.fn.has("win32") == 1 then
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
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", jar,
      "-configuration", config,
      "-data", workspace
    },
    on_attach = require("plugins.config.lsp").on_attach,
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
