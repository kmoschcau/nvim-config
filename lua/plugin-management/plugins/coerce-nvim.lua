-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "gregorias/coerce.nvim",
  dependencies = {
    -- cspell:disable
    "gregorias/coop.nvim",
    -- cspell:enable
  },
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
