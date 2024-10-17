-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "tris203/hawtkeys.nvim",
  -- @type HawtKeyConfig -- Does not work well, no optional fields
  opts = {
    customMaps = {
      ["lazy"] = {
        method = "lazy",
      },
    },
  },
}
