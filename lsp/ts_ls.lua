local common = require "lsp.common"

local ts = common.settings.typescript

local filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
}

---@type vim.lsp.Config
return {
  filetypes = filetypes,
  -- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#initializationoptions
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = require("mason-registry")
          .get_package("vue-language-server")
          :get_install_path() .. "/node_modules/@vue/language-server",
        languages = filetypes,
      },
    },
    preferences = ts.preferences,
  },
  root_dir = function(bufnr, on_dir)
    local config =
      require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)
    if config.ecma_server ~= "ts_ls" then
      return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      require("lspconfig.util").root_pattern(
        "tsconfig.json",
        "jsconfig.json",
        "package.json",
        ".git"
      )(fname)
    )
  end,
  settings = {
    javascript = common.settings.javascript,
    typescript = ts,
  },
}
