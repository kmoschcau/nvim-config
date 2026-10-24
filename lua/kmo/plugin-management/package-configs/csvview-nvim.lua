-- cspell:words csvview textobject

require("csvview").setup {
  view = {
    display_mode = "border",
  },
  -- selene: allow(mixed_table)
  keymaps = {
    textobject_field_inner = { "if", mode = { "o", "x" } },
    textobject_field_outer = { "af", mode = { "o", "x" } },
    jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
    jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
  },
}
