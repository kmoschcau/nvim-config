return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update { with_sync = true }()
  end,
  main = "nvim-treesitter.configs",
  opts = {
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
      "regex",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
    },
    auto_install = true,

    -- modules below
    autotag = {
      enable = true,
    },
    endwise = {
      enable = true,
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = {
        "javascript",
        "typescript",
      },
    },
    matchup = {
      enable = true,
    },
    playground = {
      enable = true,
    },
    query_linter = {
      enable = true,
    },
  },
}
