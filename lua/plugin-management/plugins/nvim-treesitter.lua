return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update { with_sync = true }()
  end,
  config = function()
    local parser_config =
      require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.gotmpl = {
      install_info = {
        url = "https://github.com/ngalaiko/tree-sitter-go-template",
        files = { "src/parser.c" },
      },
    }
    vim.treesitter.language.register("gotmpl", "helm")

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
        "gotmpl",
        "gpg",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,

      -- modules below

      -- windwp/nvim-ts-autotag
      autotag = {
        enable = true,
      },

      -- RRethy/nvim-treesitter-endwise
      endwise = {
        enable = true,
      },

      -- nvim-treesitter/nvim-treesitter
      highlight = {
        enable = true,
      },

      -- nvim-treesitter/nvim-treesitter
      indent = {
        enable = true,
        disable = {
          "javascript",
          "typescript",
        },
      },

      -- andymass/vim-matchup
      matchup = {
        enable = true,
      },
    }
  end,
}
