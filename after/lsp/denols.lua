local tsserver = require "kmo.lsp.common.tsserver"
local ts = tsserver.settings.typescript

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local config =
      require("neoconf").get("lsp", require("kmo.neoconf-schemas.lsp").defaults)
    if config.ecma_server ~= "denols" then
      return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      require("lspconfig.util").root_pattern(
        vim.lsp.config["denols"].root_markers
      )(fname)
    )
  end,
  -- https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno
  settings = {
    deno = {
      codeLens = {
        implementations = ts.implementationsCodeLens.enabled,
        references = ts.referencesCodeLens.enabled,
        referencesAllFunctions = ts.referencesCodeLens.showOnAllFunctions,
      },
      inlayHints = tsserver.ts_inlay_vs_code_settings,
    },
  },
}
