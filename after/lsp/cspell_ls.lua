-- cspell:words lspconfig

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    if
      require("linters.common.cspell").enable_cspell(
        vim.bo[bufnr].buftype,
        vim.bo[bufnr].filetype
      )
    then
      return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      require("lspconfig.util").root_pattern(
        vim.lsp.config["cspell_ls"].root_markers
      )(fname)
    )
  end,
}
