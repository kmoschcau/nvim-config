local tsserver = require "kmo.lsp.common.tsserver"

---@type vim.lsp.Config
return {
  filetypes = tsserver.filetypes,
  -- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#initializationoptions
  init_options = {
    plugins = {
      tsserver.vue_plugin,
    },
    preferences = tsserver.settings.typescript.preferences,
  },
  root_dir = function(bufnr, on_dir)
    local config =
      require("neoconf").get("lsp", require("kmo.neoconf-schemas.lsp").defaults)
    if config.ecma_server ~= "ts_ls" then
      return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      require("lspconfig.util").root_pattern(
        vim.lsp.config["ts_ls"].root_markers
      )(fname)
    )
  end,
  settings = tsserver.settings,
}
