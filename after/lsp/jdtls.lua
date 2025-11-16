-- cspell:words jdtls

local mason_utils = require "kmo.plugin-management.mason-utils"

---Get the config file path for jdtls.
---@param jdtls_package_path string the mason registry package path for jdtls
---@return string
local function get_config_path(jdtls_package_path)
  local os
  if vim.fn.has "win32" == 1 then
    os = "win"
  else
    os = "linux"
  end

  return vim.fs.joinpath(jdtls_package_path, "config_" .. os)
end

---Get the launcher jar file path for jdtls.
---@param jdtls_package_path string the mason registry package path for jdtls
---@return string
local function get_launch_jar_path(jdtls_package_path)
  return vim.fn.glob(
    vim.fs.joinpath(
      jdtls_package_path,
      "plugins",
      "org.eclipse.equinox.launcher_*.jar"
    )
  )
end

---Get the workspace path for the current working directory.
---@return string
local function get_workspace_path()
  return vim.fs.normalize(
    "~/.local/share/jdt-ws/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
  )
end

---Get the command for jdtls.
---@param jdtls_package_path string the mason registry package path for jdtls
---@return string[]
local function get_cmd(jdtls_package_path)
  return {
    "java",
    -- cspell:disable
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    -- cspell:enable
    "-Xmx1G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    get_launch_jar_path(jdtls_package_path),
    "-configuration",
    get_config_path(jdtls_package_path),
    "-data",
    get_workspace_path(),
  }
end

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
      ) --[[ @as string[] ]]
    )
  end

  vim.notify(
    "Loaded jdtls plugins:\n" .. vim.inspect(bundles),
    vim.log.levels.DEBUG
  )

  return bundles
end

local jdtls = require "jdtls"

---@type vim.lsp.Config
return {
  cmd = get_cmd(vim.fn.expand "$MASON/packages/jdtls"),
  init_options = { bundles = get_plugin_bundle_paths() },
  on_attach = function()
    ---@diagnostic disable-next-line: missing-fields
    jdtls.setup_dap {
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
        },
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
