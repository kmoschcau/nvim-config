return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "nvim-treesitter/playground",
  build = function()
    require("nvim-treesitter.install").update { with_sync = true }
  end,
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { "javascript", "typescript" },
    },
    playground = {
      enable = true,
    },
    query_linter = {
      enable = true,
    },
  },
}
