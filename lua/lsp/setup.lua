-- vim: foldmethod=marker

local common = require "lsp.common"

--- @class LspAttachData
--- @field client_id number the number of the LSP client

--- @class LspAttachArgs
--- @field buf number the buffer number
--- @field data LspAttachData the LspAttach specific data

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP: Set up things when attaching with a language client to a server.",
  group = common.augroup,
  --- @param args LspAttachArgs the autocmd args
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    require "lsp.attach"(client, args.buf)
  end,
})
