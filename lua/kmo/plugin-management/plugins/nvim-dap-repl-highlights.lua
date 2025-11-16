-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "LiadOz/nvim-dap-repl-highlights",
  dependencies = {
    -- cspell:disable
    "nvim-treesitter/nvim-treesitter",
    -- cspell:enable
  },
  config = function()
    local has_treesitter, treesitter = pcall(require, "nvim-treesitter")
    if not has_treesitter then
      return
    end

    require("nvim-dap-repl-highlights").setup()
    treesitter.install { "dap_repl" }
  end,
}
