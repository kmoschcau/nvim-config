local tsserver = require "kmo.lsp.common.tsserver"

---@type vim.lsp.Config
return {
  filetypes = tsserver.filetypes,
  on_attach = function(client, bufnr)
    require("kmo.lsp.common").create_source_actions_user_command(client, bufnr)
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
