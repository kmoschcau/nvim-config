local M = {}

--- Get the config file path for jdtls.
--- @param jdtls_package Package the mason registry package for jdtls
--- @return string
local function get_config_path(jdtls_package)
  local os
  if vim.fn.has "win32" == 1 then
    os = "win"
  else
    os = "linux"
  end

  return jdtls_package:get_install_path() .. "/config_" .. os
end

--- Get the launcher jar file path for jdtls.
--- @param jdtls_package Package the mason registry package for jdtls
--- @return string
local function get_launch_jar_path(jdtls_package)
  return vim.fn.glob(
    jdtls_package:get_install_path()
      .. "/plugins/org.eclipse.equinox.launcher_*.jar"
  )
end

--- Get the workspace path for the current working directory.
--- @return string
local function get_workspace_path()
  return vim.fs.normalize(
    "~/.local/share/jdt-ws/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
  )
end

--- Get the command for jdtls.
--- @param jdtls_package Package the mason registry package for jdtls
--- @return string[]
local function get_cmd(jdtls_package)
  return {
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
    get_launch_jar_path(jdtls_package),
    "-configuration",
    get_config_path(jdtls_package),
    "-data",
    get_workspace_path(),
  }
end

--- Get the plugin bundle paths for jdtls.
--- @return string[]
local function get_plugin_bundle_paths()
  local mason_reg = require "mason-registry"

  local bundles = {}

  local java_debug_package = mason_reg.get_package "java-debug-adapter"

  vim.notify(
    "java-debug-adapter installed: "
      .. vim.inspect(java_debug_package:is_installed()),
    vim.log.levels.DEBUG
  )

  if java_debug_package:is_installed() then
    table.insert(
      bundles,
      vim.fn.glob(
        java_debug_package:get_install_path()
          .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        true
      )
    )
  end

  local java_test_package = mason_reg.get_package "java-test"

  vim.notify(
    "java-test installed: " .. vim.inspect(java_test_package:is_installed()),
    vim.log.levels.DEBUG
  )

  if java_test_package:is_installed() then
    vim.list_extend(
      bundles,
      vim.split(
        vim.fn.glob(
          java_test_package:get_install_path()
            .. "/extension/server/com.microsoft.java.test.plugin-*.jar",
          true
        ),
        "\n"
      )
    )
  end

  vim.notify(
    "Loaded jdtls plugins:\n" .. vim.inspect(bundles),
    vim.log.levels.DEBUG
  )

  return bundles
end

--- Start the language server (if not started), and attach the current buffer.
M.start_or_attach = function()
  local jdtls_package = require("mason-registry").get_package "jdtls"

  if not jdtls_package:is_installed() then
    return
  end

  local common = require "lsp.common"
  local jdtls = require "jdtls"

  jdtls.start_or_attach {
    capabilities = common.capabilities,
    cmd = get_cmd(jdtls_package),
    init_options = { bundles = get_plugin_bundle_paths() },
    on_attach = function()
      jdtls.setup_dap { hotcodereplace = "auto" }
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
            "#",
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
end

return M
