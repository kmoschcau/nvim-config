-- vim: foldmethod=marker foldlevelstart=0

-- Specify a list of plugins.
return require("packer").startup(function()
  local use = require("packer").use

  -- packer {{{1
  -- Let packer manage packer itself.
  use "wbthomason/packer.nvim"

  -- language servers {{{1
  -- Built-in LSP {{{2
  -- LSP server installer
  use "williamboman/mason.nvim"

  -- Bridging the gap between mason and lspconfig
  use "williamboman/mason-lspconfig.nvim"

  -- Automatically install configured null-ls sources with mason
  use "jay-babu/mason-null-ls.nvim"

  -- Automatically install configured nvim-dap sources with mason
  use "jay-babu/mason-nvim-dap.nvim"

  -- Configurations for built-in LSP
  use "neovim/nvim-lspconfig"

  -- Tool to allow non-LSP sources to use LSP functions
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  -- language specific extensions {{{3
  -- java
  use "mfussenegger/nvim-jdtls"

  -- typescript
  use "jose-elias-alvarez/typescript.nvim"

  -- LSP related plugins {{{2

  -- show LSP progress
  use "j-hui/fidget.nvim"

  -- (auto)completion {{{1
  -- snippets {{{2
  -- snippet engine
  use "L3MON4D3/LuaSnip"

  -- community maintained snippet collection for all sorts of langs
  use "rafamadriz/friendly-snippets"

  -- nvim-cmp {{{2
  -- autocompletion framework
  use "hrsh7th/nvim-cmp"

  -- cmp LSP source
  use "hrsh7th/cmp-nvim-lsp"

  -- cmp buffer source
  use "hrsh7th/cmp-buffer"

  -- cmp path source
  use "hrsh7th/cmp-path"

  -- cmp git source
  use { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" }

  -- cmp path source
  use "hrsh7th/cmp-cmdline"

  -- cmp DAP source
  use "rcarriga/cmp-dap"

  -- cmp LuaSnip source
  use "saadparwaiz1/cmp_luasnip"

  -- debugging plugins {{{1

  -- DAP (Debug Adapter Protocol) implementation
  use "mfussenegger/nvim-dap"

  -- ui for nvim-dap
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  -- syntax plugins {{{1
  -- treesitter {{{2
  -- treesitter itself
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- helps with analysing the treesitter tree
  use "nvim-treesitter/playground"

  -- show the context of the current function up top
  use "romgrk/nvim-treesitter-context"

  -- specific file syntaxes {{{2
  -- logfile syntax
  use "MTDL9/vim-log-highlighting"

  -- maven syntax
  use "NLKNguyen/vim-maven-syntax"

  -- a lot of helpful things dealing with CSV
  use "chrisbra/csv.vim"

  -- }}}2

  -- colored highlighting for CSS like hex color values
  use "norcalli/nvim-colorizer.lua"

  -- some niceties for markdown
  use "ixru/nvim-markdown"

  -- file tree {{{1
  -- provides a better file browser than built-in netrw
  use "nvim-tree/nvim-tree.lua"

  -- integrate nvim-tree actions with LSP events
  use {
    "antosha417/nvim-lsp-file-operations",
    requires = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
  }

  -- status line plugins {{{1
  -- pretty, segmented and configurable status line in lua
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
  }

  -- devicons plugins {{{1
  -- dev icons for lua plugins
  use "nvim-tree/nvim-web-devicons"

  -- dev icons for LSP completion
  use "onsails/lspkind.nvim"

  -- microsoft codeicons
  use "mortepau/codicons.nvim"

  -- git plugins {{{1
  -- show git line status in gutter
  use "lewis6991/gitsigns.nvim"

  -- provide integrated git handling in the editor
  use "tpope/vim-fugitive"

  -- movement and editing plugins {{{1
  -- makes motion through words more granular
  use "chaoren/vim-wordmotion"

  -- adds a focus mode to vim
  use "folke/zen-mode.nvim"

  -- better document highlight provider than manual
  use "RRethy/vim-illuminate"

  -- adds highlighting of only the local scope
  use {
    "folke/twilight.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
  }

  -- adds table formatting commands
  use "godlygeek/tabular"

  -- various handling of variants of words
  -- I mainly use it for the case coercion
  use "tpope/vim-abolish"

  -- toggle line commenting with a key map
  use "numToStr/Comment.nvim"

  -- automatically add ending pairs of characters or words
  use "tpope/vim-endwise"

  -- makes a lot of Tim Pope's plugins repeatable
  use "tpope/vim-repeat"

  -- add ability to use Ctrl-A/X to manipulate dates
  use "tpope/vim-speeddating"

  -- add maps and commands to surround stuff
  use "windwp/nvim-autopairs"

  -- lots of maps to toggle options and do stuff around current line
  use "tpope/vim-unimpaired"

  -- fuzzy finder plugins {{{1
  -- generic fuzzy finder framework
  use {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- fzf integration for telescope
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- misc plugins {{{1
  -- out of the box setup for neovim lua development
  use "folke/neodev.nvim"

  -- better notifications
  use "rcarriga/nvim-notify"

  -- better input and select ui
  use "stevearc/dressing.nvim"

  -- allows better handling for local vimrc files
  use "embear/vim-localvimrc"

  -- lightning fast markdown preview in browser
  use { "euclio/vim-markdown-composer", run = "cargo build --release" }

  -- a scratchpad for lua
  use "rafcamlet/nvim-luapad"
  -- }}}1
end)
