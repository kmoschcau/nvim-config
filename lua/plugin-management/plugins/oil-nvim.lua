-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "stevearc/oil.nvim",
  dependencies = {
    -- cspell:disable
    "echasnovski/mini.nvim",
    -- cspell:enable
  },
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
