--- @type LazyPluginSpec
return {
  "gregorias/coerce.nvim",
  --- @type CoerceConfigUser
  opts = {
    default_mode_keymap_prefixes = {
      normal_mode = "<Space>cc",
      motion_mode = "<Space>cr",
      visual_mode = "<Space>cr",
    },
  },
}
