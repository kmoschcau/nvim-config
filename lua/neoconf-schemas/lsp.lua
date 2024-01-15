--- @class NeoconfLsp
--- @field use_volar boolean Whether to use volar

return {
  defaults = {
    use_volar = false,
  },
  schema = {
    use_volar = {
      type = "boolean",
      description = "Whether to use volar in place of a typescript server",
      default = false,
    }
  }
}
