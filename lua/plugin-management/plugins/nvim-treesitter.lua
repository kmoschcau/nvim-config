return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "nvim-treesitter/playground",
  build = function()
    require("nvim-treesitter.install").update { with_sync = true }
  end,
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      -- This should only include what should be there on first setup, not what
      -- I end up using over time.
      "bash",
      -- "comment", -- commets are slowing down TS a lot currently
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
    ignore_install = {
      "comment", -- see above
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
    playground = {
      enable = true,
    },
    query_linter = {
      enable = true,
    },
  },
}
