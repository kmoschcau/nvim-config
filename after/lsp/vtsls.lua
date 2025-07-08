-- cspell:words lspconfig neoconf vtsls

local tsserver = require "lsp.common.tsserver"

---@type vim.lsp.Config
return {
  filetypes = tsserver.filetypes,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspTypescriptSourceAction",
      function()
        local source_actions = vim.tbl_filter(function(action)
          return vim.startswith(action, "source.")
        end, client.server_capabilities.codeActionProvider.codeActionKinds)

        vim.lsp.buf.code_action {
          context = {
            only = source_actions,
          },
        }
      end,
      {}
    )
  end,
  root_dir = function(bufnr, on_dir)
    local config =
      require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)
    if config.ecma_server ~= "vtsls" then
      return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      require("lspconfig.util").root_pattern(
        vim.lsp.config["vtsls"].root_markers
      )(fname)
    )
  end,
  settings = vim.tbl_extend("force", tsserver.settings, {
    vtsls = {
      tsserver = {
        globalPlugins = {
          tsserver.vue_plugin,
        },
      },
    },
  }),
}
