-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        -- This should only include languages that are not automatically
        -- installed, most often because they are injected.
        "comment",
        "luadoc",
        "markdown",
        "markdown_inline",
        "mermaid",
        "printf",
        "regex",
      },
      auto_install = true,

      -- modules below

      -- RRethy/nvim-treesitter-endwise
      endwise = {
        enable = true,
      },

      -- nvim-treesitter/nvim-treesitter
      highlight = {
        enable = true,
      },

      -- nvim-treesitter/nvim-treesitter
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<Tab>",
          scope_incremental = "<CR>",
          node_decremental = "<S-Tab>",
        },
      },

      -- nvim-treesitter/nvim-treesitter
      indent = {
        enable = true,
      },

      -- andymass/vim-matchup
      matchup = {
        enable = true,
      },
    }
  end,
}
