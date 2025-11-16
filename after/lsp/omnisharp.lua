---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local config =
      require("neoconf").get("lsp", require("kmo.neoconf-schemas.lsp").defaults)
    if config.dotnet_server ~= "omnisharp" then
      return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      require("lspconfig.util").root_pattern(
        vim.lsp.config["omnisharp"].root_markers
      )(fname)
    )
  end,
  -- Configuration is done in `~/.omnisharp/`.
}
