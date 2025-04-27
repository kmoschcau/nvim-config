return {
  defaults = {
    --- Which LSP server to use for .NET.
    --- @type "omnisharp" | "roslyn"
    dotnet_server = "roslyn",
    --- Which LSP server to use for ECMAScript.
    --- @type "denols" | "ts_ls" | "typescript-tools"
    ecma_server = "ts_ls",
  },
  schema = {
    dotnet_server = {
      type = "string",
      description = "Which LSP server to use for .NET.",
      default = "roslyn",
      enum = { "omnisharp", "roslyn" },
    },
    ecma_server = {
      type = "string",
      description = "Which LSP server to use for ECMAScript.",
      default = "ts_ls",
      enum = { "denols", "ts_ls", "typescript-tools" },
    },
  },
}
