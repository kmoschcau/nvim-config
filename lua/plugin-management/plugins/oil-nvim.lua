-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  config = function()
    require("oil").setup {
      columns = {
        "icon",
        { "permissions", highlight = "@attribute" },
      },
      win_options = {
        colorcolumn = "",
        signcolumn = "yes:2",
      },
      lsp_file_methods = {
        autosave_changes = "unmodified",
      },
    }

    vim.keymap.set("n", "-", require("oil.actions").parent.callback, {
      desc = "Oil: Open parent directory of current buffer.",
    })
  end,
}
