-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  config = function()
    --- @type oil.setupOpts
    require("oil").setup {
      columns = {
        "icon",
        { "permissions", highlight = "Material_SynDecorator" },
      },
      win_options = {
        colorcolumn = "",
        signcolumn = "yes:2",
      },
      lsp_file_methods = {
        autosave_changes = true,
      },
    }

    vim.keymap.set("n", "-", require("oil.actions").parent.callback, {
      desc = "Oil: Open parent directory of current buffer.",
    })
  end,
}
