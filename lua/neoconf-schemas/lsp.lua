-- cspell:words denols omnisharp

local M = {}

M.defaults = {
  ---Which LSP server to use for .NET.
  ---@type "omnisharp" | "roslyn_ls" | "roslyn.nvim"
  dotnet_server = "roslyn.nvim",
  ---Which LSP server to use for ECMAScript.
  ---@type "denols" | "ts_ls" | "typescript-tools"
  ecma_server = "typescript-tools",
}

M.schema = {
  dotnet_server = {
    type = "string",
    description = "Which LSP server to use for .NET.",
    default = M.defaults.dotnet_server,
    enum = { "omnisharp", "roslyn_ls", "roslyn.nvim" },
  },
  ecma_server = {
    type = "string",
    description = "Which LSP server to use for ECMAScript.",
    default = M.defaults.ecma_server,
    enum = { "denols", "ts_ls", "typescript-tools" },
  },
}

return M
