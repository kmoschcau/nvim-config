require("oil").setup {
  -- selene: allow(mixed_table)
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

require("oil-lsp-diagnostics").setup()
require("oil-git-status").setup {}

vim.keymap.set("n", "-", require("oil.actions").parent.callback, {
  desc = "Oil: Open parent directory of current buffer.",
})
