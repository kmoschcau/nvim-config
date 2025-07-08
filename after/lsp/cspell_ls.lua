-- cspell:words lspconfig

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    if
      vim.list_contains(
        { "cmd", "msg", "pager", "dialog", "fugitive" },
        vim.bo[bufnr].filetype
      ) or vim.list_contains({ "help" }, vim.bo[bufnr].buftype)
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
