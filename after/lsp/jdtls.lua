-- cspell:words jdtls

local mason_utils = require "kmo.plugin-management.mason-utils"

---Get the plugin bundle paths for jdtls.
---@return string[]
local function get_plugin_bundle_paths()
  local bundles = {}

  if mason_utils.is_package_installed "java-debug-adapter" then
    table.insert(
      bundles,
      vim.fn.expand "$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
    )
  end

  if mason_utils.is_package_installed "java-test" then
    vim.list_extend(
      bundles,
      vim.fn.expand(
        "$MASON/packages/java-test/extension/server/com.microsoft.java.test.plugin-*.jar",
        true,
        true
      ) --[=[@as string[]]=]
    )
  end

  vim.notify(
    "Loaded jdtls plugins:\n" .. vim.inspect(bundles),
    vim.log.levels.DEBUG
  )

  return bundles
end

local function get_runtimes()
  local runtimes
  if vim.fn.has "win32" == 1 then
    runtimes = {
      {
        name = "JavaSE-21",
        path = "C:/Program Files/Eclipse Adoptium/jdk-21.0.9.10-hotspot",
      },
    }
  else
    runtimes = {
      {
        name = "JavaSE-1.8",
        path = "/usr/lib/jvm/java-8-openjdk-amd64",
      },
      {
        name = "JavaSE-11",
        path = "/usr/lib/jvm/java-11-openjdk-amd64",
      },
      {
        name = "JavaSE-23",
        path = "/usr/lib/jvm/java-23-openjdk",
      },
    }
  end

  return runtimes
end

---@type vim.lsp.Config
return {
  init_options = { bundles = get_plugin_bundle_paths() },
  on_attach = function()
    ---@diagnostic disable-next-line: missing-fields
    require("jdtls").setup_dap {
      hotcodereplace = "auto", -- cspell:disable-line
    }
  end,
  -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      codeGeneration = {
        hashCodeEquals = {
          useInstanceof = true,
          useJava7Objects = true,
        },
        insertionLocation = "lastMember",
        toString = {
          codeStyle = "STRING_BUILDER_CHAINED",
        },
        useBlocks = true,
      },
      compile = {
        nullAnalysis = {
          mode = "automatic",
        },
      },
      completion = {
        guessMethodArguments = "insertBestGuessedArguments",
        importOrder = {
          -- cspell:disable
          "#",
          "com",
          "java",
          "javassist",
          "javax",
          "org",
          -- cspell:enable
        },
        overwrite = false,
      },
      configuration = {
        runtimes = get_runtimes(),
        updateBuildConfiguration = "automatic",
      },
      eclipse = {
        downloadSources = true,
      },
      edit = {
        validateAllOpenBuffersOnChanges = true,
      },
      format = {
        enabled = false,
        settings = {
          url = "~/.config/nvim/external-config/eclipse-formatter.xml",
        },
      },
      implementationsCodeLens = {
        enabled = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = true,
        },
      },
      maven = {
        downloadSources = true,
      },
      quickfix = {
        showAt = "problem",
      },
      referencesCodeLens = {
        enabled = true,
      },
      signatureHelp = {
        description = {
          enabled = true,
        },
      },
      redhat = {
        telemetry = {
          enabled = false,
        },
      },
    },
  },
}
