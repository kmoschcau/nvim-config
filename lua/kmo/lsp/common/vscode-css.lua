local M = {}

-- https://code.visualstudio.com/docs/reference/default-settings
-- https://code.visualstudio.com/docs/languages/css
local style = {
  format = {
    enable = false,
  },
  lint = {
    duplicateProperties = "warning",
    idSelector = "warning",
    ieHack = "warning",
    importStatement = "warning",
    important = "warning",
    unknownProperties = "ignore", -- enforced via stylelint
    zeroUnits = "warning",
  },
  validate = false, -- works badly with tailwind, so use stylelint instead
}

M.settings = {
  css = vim.tbl_deep_extend("force", style, {
    -- cspell:disable-next-line
    customdata = {
      "~/.config/nvim/external-config/container.css-data.json",
    },
  }),
  less = style,
  scss = style,
}

return M
