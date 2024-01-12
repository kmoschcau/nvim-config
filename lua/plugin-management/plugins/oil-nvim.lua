return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup {
      columns = {
        "icon",
        { "permissions", highlight = "Material_SynDecorator" },
      },
      win_options = {
        colorcolumn = "",
        signcolumn = "yes:2",
      },
      lsp_rename_autosave = true,
    }

    vim.keymap.set("n", "-", require("oil.actions").parent.callback, {
      desc = "Oil: Open parent directory of current buffer.",
    })
  end,
}
