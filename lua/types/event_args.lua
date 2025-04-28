---@meta _
error "Cannot require a meta file"

---Autocmd callback arguments, specific to the |LspAttach| event.
---@class LspAttachArgs: vim.api.keyset.create_autocmd.callback_args
---
---the LspAttach specific data
---@field data LspAttachData

---Autocmd callback data, specific to the |LspAttach| event.
---@class LspAttachData
---
---the ID of the LSP client
---@field client_id number

---Autocmd callback arguments, specific to the |TermRequest| event.
---@class TermRequestArgs: vim.api.keyset.create_autocmd.callback_args
---
---the TermRequest specific data
---@field data TermRequestData

---Autocmd callback data, specific to the |TermRequest| event.
---@class TermRequestData
---
---the received sequence
---@field sequence string
---
---(1,0)-indexed, buffer-relative position of the cursor when the sequence was
---received
---@field cursor [number, number]
