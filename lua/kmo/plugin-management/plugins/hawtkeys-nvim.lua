-- cspell:words hawt

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
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
