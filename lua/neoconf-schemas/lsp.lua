return {
  defaults = {
    --- Which LSP server to use for ECMAScript.
    --- @type "denols" | "ts_ls" | "typescript-tools"
    ecma_server = "typescript-tools",
  },
  schema = {
    ecma_server = {
      type = "string",
      description = "Which LSP server to use for ECMAScript.",
      default = "typescript-tools",
      enum = { "denols", "ts_ls", "typescript-tools" },
    },
  },
}
