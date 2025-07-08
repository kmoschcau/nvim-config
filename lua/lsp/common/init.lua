-- cspell:words omnisharp

local M = {}

---The autocommand group for LSP init autocommands.
M.augroup = vim.api.nvim_create_augroup("InitNvimLanguageServer", {})

local has_blink, blink = pcall(require, "blink.cmp")

---Generated capabilities for the LSP client
M.capabilities = has_blink and blink.get_lsp_capabilities()
  or vim.lsp.protocol.make_client_capabilities()

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

---Common configuration settings shared between multiple servers
---This mostly affects VS Code extracted language servers.
---https://code.visualstudio.com/docs/reference/default-settings
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
}

---Log the given client's server's capabilities
---@param client vim.lsp.Client | nil the LSP client to log capabilities for
---@param buf_id? integer the buffer number, defaults to 0
function M.log_capabilities(client, buf_id)
  if client == nil then
    return
  end

  if not package.loaded["snacks"] then
    -- We shouldn't log overly verbose messages when the notification plugin
    -- isn't available.
    return
  end

  local buffer_name = vim.api.nvim_buf_get_name(buf_id or 0)
  local title = "Capabilities for " .. client.name .. " at " .. buffer_name

  local longest_cap = 0
  local longest_meth = 0
  local entries = {}
  for meth_name, capability in
    pairs(
      vim.lsp.protocol._request_name_to_capability
        or vim.lsp._request_name_to_capability
        or {}
    )
  do
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

---Check whether the given client's server supports the given LSP method. If
---the given client is `nil`, this always returns false.
---@param client vim.lsp.Client | nil the LSP client whose server to check
---@param method string the method name of the method to check
---@return boolean
function M.supports_method(client, method)
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

---@alias KeymapImplementation "nvim" | "snacks" | "omnisharp_extended" | nil

---Determine which implementation to use for a given keymap. This does not need
---to be used for all keymaps, just the ones where multiple implementations are
---available.
---@param buf integer the buffer number
---@param client vim.lsp.Client | nil the LSP client for the buffer
---@param has_snacks boolean whether snacks is available
---@param has_omni_ext boolean whether omnisharp extended is available
---@return KeymapImplementation
function M.which_keymap_implementation(buf, client, has_snacks, has_omni_ext)
  if not client then
    return nil
  end

  local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
  if filetype == "cs" and has_omni_ext then
    return client.name == "omnisharp" and "omnisharp_extended" or nil
  end

  return has_snacks and "snacks" or "nvim"
end

---@class ChooseKeymapImplOptions
---
---the snacks implementation
---@field snacks_impl? function
---
---the omnisharp extended implementation
---@field omni_ext_impl? function

---Select from the given keymap implementations.
---@param keymap_implementation KeymapImplementation the determined implementation
---@param nvim_impl function the native Neovim implementation
---@param opts? ChooseKeymapImplOptions the implementation options
---@return function | nil, KeymapImplementation | nil
function M.choose_keymap_implementation(keymap_implementation, nvim_impl, opts)
  local o = opts or {}

  if keymap_implementation == "omnisharp_extended" then
    if o.omni_ext_impl then
      return o.omni_ext_impl, "omnisharp_extended"
    end

    if o.snacks_impl then
      return o.snacks_impl, "snacks"
    end

    return nvim_impl, "nvim"
  elseif keymap_implementation == "snacks" then
    if o.snacks_impl then
      return o.snacks_impl, "snacks"
    end

    return nvim_impl, "nvim"
  elseif keymap_implementation == "nvim" then
    return nvim_impl, "nvim"
  end

  return nil, nil
end

---Create a wrapper function that calls the given function with the given
---options.
---@param func function
---@param options table
---@return function
function M.with_options(func, options)
  return function()
    func(options)
  end
end

return M
