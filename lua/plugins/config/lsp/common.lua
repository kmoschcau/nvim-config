local M = {}

--- The autocommand group for LSP init autocommands.
M.augroup = vim.api.nvim_create_augroup("LanguageServer_InitVim", {})

--- Generated capabilities for the LSP client
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

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

--- Log the given client's server's capabilities
--- @param client lsp.Client|nil the LSP client to log capabilities for
--- @param buf_id? integer the buffer number, defaults to 0
M.log_capabilities = function(client, buf_id)
  if client == nil then
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
--- @param client lsp.Client|nil the LSP client whose server to check
--- @param method string the method name of the method to check
--- @return boolean
M.supports_method = function(client, method)
  if client == nil then
    return false
  end

  if client.supports_method then
    return client.supports_method(method)
  end

  return vim.tbl_get(
    client.server_capabilities or {},
    unpack(vim.lsp._request_name_to_capability[method])
  ) and true or false
end

return M
