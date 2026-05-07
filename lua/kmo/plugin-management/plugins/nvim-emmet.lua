-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "olrtg/nvim-emmet",
  config = function()
    vim.keymap.set({ "n", "x" }, "<Space>ew", function()
      require("nvim-emmet").wrap_with_abbreviation()
    end, { desc = "nvim-emmet: Wrap with abbreviation." })
  end,
}
