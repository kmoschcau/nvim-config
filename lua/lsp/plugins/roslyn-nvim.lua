local config =
  require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)
if config.dotnet_server ~= "roslyn.nvim" then
  return
end

require("roslyn").setup {
  cmd = require("lsp.helpers").get_roslyn_cmd(),
  ---@diagnostic disable-next-line: missing-fields
  config = {
    capabilities = vim.tbl_deep_extend(
      "error",
      require("lsp.common").capabilities,
      {
        textDocument = {
          _vs_onAutoInsert = { dynamicRegistration = false },
        },
      }
    ),
    handlers = vim.tbl_deep_extend("error", require "rzls.roslyn_handlers", {
      ["textDocument/_vs_onAutoInsert"] = function(err, result, _)
        if err or not result then
          return
        end

        require("lsp.vs-text-edit").apply_vs_text_edit(result._vs_textEdit)
      end,
    }),
  },
  filewatching = "off",
}

local augroup = vim.api.nvim_create_augroup("RoslynLanguageServer", {})
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Roslyn: Set up things when attaching to a buffer.",
  group = augroup,
  ---@param attach_args LspAttachArgs the autocmd args
  callback = function(attach_args)
    local client = vim.lsp.get_client_by_id(attach_args.data.client_id)

    if client and client.name == "roslyn" then
      vim.api.nvim_create_autocmd("InsertCharPre", {
        desc = "Roslyn: Trigger an auto insert on '/'.",
        group = augroup,
        buffer = attach_args.buf,
        callback = function()
          local char = vim.v.char

          if char ~= "/" then
            return
          end

          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          row, col = row - 1, col + 1
          local uri = vim.uri_from_bufnr(attach_args.buf)

          local params = {
            _vs_textDocument = { uri = uri },
            _vs_position = { line = row, character = col },
            _vs_ch = char,
            _vs_options = {
              tabSize = vim.bo[attach_args.buf].tabstop,
              insertSpaces = vim.bo[attach_args.buf].expandtab,
            },
          }

          -- NOTE: we should send textDocument/_vs_onAutoInsert request only after buffer has changed.
          vim.defer_fn(function()
            vim.lsp.buf_request(
              attach_args.buf,
              ---@diagnostic disable-next-line: param-type-mismatch
              "textDocument/_vs_onAutoInsert",
              params
            )
          end, 1)
        end,
      })
    end
  end,
})
