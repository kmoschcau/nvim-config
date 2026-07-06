---@type vim.lsp.Config
return {
  filetypes = { "yaml.azure-pipelines" },
  -- https://github.com/redhat-developer/yaml-language-server?tab=readme-ov-file#language-server-settings
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
          "/azure-pipeline*.y*l",
          "/*.azure*",
          "Azure-Pipelines/**/*.y*l",
          "Pipelines/*.y*l",
        },
      },
      schemastore = {
        enable = true,
      },
    },
  },
}
