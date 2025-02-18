local M = {}

--- The autocommand group for LSP init autocommands.
M.augroup = vim.api.nvim_create_augroup("InitNvimLanguageServer", {})

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local has_blink, blink = pcall(require, "blink.cmp")

--- Generated capabilities for the LSP client
M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  has_cmp and cmp_nvim_lsp.default_capabilities() or {},
  has_blink and blink.get_lsp_capabilities() or {}
)

-- https://code.visualstudio.com/docs/languages/css
local style = {
  format = {
    enable = false,
  },
  lint = {
    duplicateProperties = "warning",
    idSelector = "warning",
    ieHack = "warning",
    importStatement = "warning",
    important = "warning",
    unknownProperties = "ignore", -- enforced via stylelint
    zeroUnits = "warning",
  },
  validate = false, -- works badly with tailwind, so use stylelint instead
}

-- https://code.visualstudio.com/docs/languages/javascript#_inlay-hints
local js_inlay_vs_code = {
  enumMemberValues = { enabled = true },
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

-- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#workspacedidchangeconfiguration
local js_inlay_tsserver = {
  includeInlayEnumMemberValueHints = js_inlay_vs_code.enumMemberValues.enabled,
  includeInlayFunctionLikeReturnTypeHints = js_inlay_vs_code.functionLikeReturnTypes.enabled,
  includeInlayFunctionParameterTypeHints = js_inlay_vs_code.parameterTypes.enabled,
  includeInlayParameterNameHints = js_inlay_vs_code.parameterNames.enabled,
  includeInlayParameterNameHintsWhenArgumentMatchesName = not js_inlay_vs_code.parameterNames.suppressWhenArgumentMatchesName,
  includeInlayPropertyDeclarationTypeHints = js_inlay_vs_code.propertyDeclarationTypes.enabled,
  includeInlayVariableTypeHints = js_inlay_vs_code.variableTypes.enabled,
  includeInlayVariableTypeHintsWhenTypeMatchesName = not js_inlay_vs_code.variableTypes.suppressWhenTypeMatchesName,
}

M.js_inlay = {
  vs_code = js_inlay_vs_code,
  tsserver = js_inlay_tsserver,
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
    js_inlay_vs_code,
    js_inlay_tsserver
  ),
  preferences = {},
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

--- Common configuration settings shared between multiple servers
--- This mostly affects VS Code extracted language servers.
--- https://code.visualstudio.com/docs/getstarted/settings#_default-settings
M.settings = {
  css = vim.tbl_deep_extend("force", style, {
    customData = {
      "~/.config/nvim/external-config/container.css-data.json",
    },
  }),
  less = style,
  scss = style,

  -- https://code.visualstudio.com/docs/languages/html
  html = {
    suggest = {
      html5 = true,
    },
    format = {
      enable = false,
    },
  },

  javascript = vim.tbl_deep_extend("force", js_like, {
    format = require("neoconf").get("vscode.javascript.format", js_like.format),
    preferences = require("neoconf").get(
      "vscode.javascript.preferences",
      js_like.preferences
    ),
  }),
  typescript = vim.tbl_deep_extend("force", js_like, {
    format = require("neoconf").get("vscode.typescript.format", js_like.format),
    preferences = require("neoconf").get(
      "vscode.typescript.preferences",
      js_like.preferences
    ),
  }),
}

--- Log the given client's server's capabilities
--- @param client vim.lsp.Client|nil the LSP client to log capabilities for
--- @param buf_id? integer the buffer number, defaults to 0
M.log_capabilities = function(client, buf_id)
  if client == nil then
    return
  end

  if not package.loaded["notify"] then
    -- We shouldn't log overly verbose messages when notify isn't available.
    return
  end

  local buffer_name = vim.api.nvim_buf_get_name(buf_id or 0)
  local title = "Capabilities for " .. client.name .. " at " .. buffer_name

  local longest_cap = 0
  local longest_meth = 0
  local entries = {}
  for meth_name, capability in pairs(vim.lsp._request_name_to_capability) do
    local cap_name = table.concat(capability, ".")
    longest_cap = math.max(longest_cap, #cap_name)
    longest_meth = math.max(longest_meth, #meth_name)

    local entry = {
      cap_marker = vim.tbl_get(
        client.server_capabilities or {},
        unpack(capability)
      ) and "[X]" or "[ ]",
      cap_name = cap_name,
      meth_marker = M.supports_method(client, meth_name) and "[X]" or "[ ]",
      meth_name = meth_name,
    }

    table.insert(entries, entry)
  end
  table.sort(entries, function(a, b)
    return a.meth_name < b.meth_name
  end)

  local lines = {}
  for _, entry in ipairs(entries) do
    table.insert(
      lines,
      string.format(
        "%s %-" .. longest_meth .. "s %s %-" .. longest_cap .. "s",
        entry.meth_marker,
        entry.meth_name,
        entry.cap_marker,
        entry.cap_name
      )
    )
  end

  vim.notify(table.concat(lines, "\n"), vim.log.levels.DEBUG, { title = title })
end

--- Check whether the given client's server supports the given LSP method. If
--- the given client is `nil`, this always returns false.
--- @param client vim.lsp.Client|nil the LSP client whose server to check
--- @param method string the method name of the method to check
--- @return boolean
M.supports_method = function(client, method)
  if client == nil then
    return false
  end

  if client.supports_method then
    return client:supports_method(method)
  end

  return vim.tbl_get(
    client.server_capabilities or {},
    unpack(vim.lsp._request_name_to_capability[method])
  ) and true or false
end

--- @alias KeymapImplementation "nvim"|"telescope"|"omnisharp_extended"|nil

--- Determine which implementation to use for a given keymap. This does not need
--- to be used for all keymaps, just the ones where multiple implementations are
--- available.
--- @param buf integer the buffer number
--- @param client vim.lsp.Client|nil the LSP client for the buffer
--- @param has_telescope boolean whether telescope is available
--- @param has_omni_ext boolean whether omnisharp extended is available
--- @return KeymapImplementation
M.which_keymap_implementation = function(
  buf,
  client,
  has_telescope,
  has_omni_ext
)
  if not client then
    return nil
  end

  local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
  if filetype == "cs" and has_omni_ext then
    return client.name == "omnisharp" and "omnisharp_extended" or nil
  end

  return has_telescope and "telescope" or "nvim"
end

--- @class ChooseKeymapImplOptions
--- @field telescope_impl? function the telescope implementation
--- @field omni_ext_impl? function the omnisharp extended implementation

--- Select from the given keymap implementations.
--- @param keymap_implementation KeymapImplementation the determined implementation
--- @param nvim_impl function the native Neovim implementation
--- @param opts? ChooseKeymapImplOptions the implementation options
--- @return function|nil, KeymapImplementation|nil
M.choose_keymap_implementation = function(
  keymap_implementation,
  nvim_impl,
  opts
)
  local o = opts or {}

  if keymap_implementation == "omnisharp_extended" then
    if o.omni_ext_impl then
      return o.omni_ext_impl, "omnisharp_extended"
    end

    if o.telescope_impl then
      return o.telescope_impl, "telescope"
    end

    return nvim_impl, "nvim"
  elseif keymap_implementation == "telescope" then
    if o.telescope_impl then
      return o.telescope_impl, "telescope"
    end

    return nvim_impl, "nvim"
  elseif keymap_implementation == "nvim" then
    return nvim_impl, "nvim"
  end

  return nil, nil
end

return M
