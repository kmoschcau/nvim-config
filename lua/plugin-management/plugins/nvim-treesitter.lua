--- @type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update { with_sync = true }()
  end,
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        -- This should only include what should be there on first setup, not what
        -- I end up using over time.
        "bash",
        "comment",
        "diff",
        "fish",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "gpg",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
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
