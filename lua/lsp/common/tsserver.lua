local M = {}

M.filetypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "vue",
}

-- https://code.visualstudio.com/docs/languages/javascript#_inlay-hints
M.js_inlay_vs_code_settings = {
  functionLikeReturnTypes = { enabled = true },
  parameterNames = {
    enabled = "all",
    suppressWhenArgumentMatchesName = false,
  },
  parameterTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  variableTypes = {
    enabled = true,
    suppressWhenTypeMatchesName = false,
  },
}

M.ts_inlay_vs_code_settings =
  vim.tbl_deep_extend("force", M.js_inlay_vs_code_settings, {
    enumMemberValues = { enabled = true },
  })

-- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#workspacedidchangeconfiguration
M.ts_inlay_tsserver_workspace_did_change_configuration = {
  includeInlayEnumMemberValueHints = M.ts_inlay_vs_code_settings.enumMemberValues.enabled,
  includeInlayFunctionLikeReturnTypeHints = M.ts_inlay_vs_code_settings.functionLikeReturnTypes.enabled,
  includeInlayFunctionParameterTypeHints = M.ts_inlay_vs_code_settings.parameterTypes.enabled,
  includeInlayParameterNameHints = M.ts_inlay_vs_code_settings.parameterNames.enabled,
  includeInlayParameterNameHintsWhenArgumentMatchesName = not M.ts_inlay_vs_code_settings.parameterNames.suppressWhenArgumentMatchesName,
  includeInlayPropertyDeclarationTypeHints = M.ts_inlay_vs_code_settings.propertyDeclarationTypes.enabled,
  includeInlayVariableTypeHints = M.ts_inlay_vs_code_settings.variableTypes.enabled,
  includeInlayVariableTypeHintsWhenTypeMatchesName = not M.ts_inlay_vs_code_settings.variableTypes.suppressWhenTypeMatchesName,
}

-- https://code.visualstudio.com/docs/languages/javascript
-- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#workspacedidchangeconfiguration
local js_like = {
  format = {
    enable = false,
  },
  implementationsCodeLens = {
    enabled = true,
  },
  inlayHints = vim.tbl_deep_extend(
    "error",
    M.ts_inlay_vs_code_settings,
    M.ts_inlay_tsserver_workspace_did_change_configuration
  ),
  -- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#preferences-options
  preferences = vim.tbl_deep_extend(
    "force",
    {},
    M.ts_inlay_tsserver_workspace_did_change_configuration
  ),
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
  updateImportsOnFileMove = {
    enabled = "always",
  },
}

local has_neoconf, neoconf = pcall(require, "neoconf")

-- https://code.visualstudio.com/docs/reference/default-settings
-- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
M.settings = {
  javascript = vim.tbl_deep_extend("force", js_like, {
    format = has_neoconf
        and neoconf.get("vscode.javascript.format", js_like.format)
      or {},
    preferences = has_neoconf
        and neoconf.get("vscode.javascript.preferences", js_like.preferences)
      or {},
  }, {
    preferences = M.ts_inlay_tsserver_workspace_did_change_configuration,
  }),
  typescript = vim.tbl_deep_extend("force", js_like, {
    format = has_neoconf
        and neoconf.get("vscode.typescript.format", js_like.format)
      or {},
    implementationsCodeLens = {
      showOnInterfaceMethods = true,
    },
    preferences = has_neoconf
        and neoconf.get("vscode.typescript.preferences", js_like.preferences)
      or {},
  }, {
    preferences = M.ts_inlay_tsserver_workspace_did_change_configuration,
  }),
}

M.vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server",
  languages = { "vue" },
  configNamespace = "typescript",
}

return M
