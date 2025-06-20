-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "gregorias/coerce.nvim",
  ---@module "coerce"
  ---@type CoerceConfigUser
  opts = {
    default_mode_keymap_prefixes = {
      normal_mode = "<Space>cc",
      motion_mode = "<Space>cr",
      visual_mode = "<Space>cr",
    },
  },
}
