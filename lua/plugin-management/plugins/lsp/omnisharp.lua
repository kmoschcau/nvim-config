local common = require "lsp.common"
local compat = require "system-compat"
local omni_ext = require "omnisharp_extended"
local lspconfig = require "lspconfig"

lspconfig.omnisharp.setup {
  cmd = { compat.append_win_ext "omnisharp" },
  capabilities = common.capabilities,
  handlers = vim.tbl_extend(
    "error",
    common.handlers,
    { ["textDocument/definition"] = omni_ext.handler }
  ),
  -- Configuration is done in `~/.omnisharp/`.
}

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP: Set up OmniSharp specific things when attaching with a language client to it.",
  group = common.augroup,
  --- @param args LspAttachArgs the autocmd args
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client == nil or client.name ~= "omnisharp" then
      return
    end

    -- textDocument/definition
    vim.keymap.set("n", "gd", omni_ext.telescope_lsp_definitions, {
      buffer = args.buf,
      desc = "LSP: Fuzzy find definitions of the symbol under the cursor.",
    })
  end,
})
