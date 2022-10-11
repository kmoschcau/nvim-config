-- vim: foldmethod=marker foldlevel=0

-- Load the packer plugin, since it is installed as optional.
vim.cmd [[packadd packer.nvim]]

-- Specify a list of plugins.
local use = require("packer").use
return require("packer").startup(function()
  -- packer {{{1
  -- Let packer manage packer itself.
  use "wbthomason/packer.nvim"

  -- language servers {{{1
  -- Built-in LSP {{{2
  -- LSP server installer
  use "williamboman/mason.nvim"

  -- Bridging the gap between mason.nvim and lspconfig
  use "williamboman/mason-lspconfig.nvim"

  -- Configurations for built-in LSP
  use "neovim/nvim-lspconfig"

  -- Experimental semantic highlighting
  use "theHamsta/nvim-semantic-tokens"

  -- language specific extensions {{{3
  -- java
  use "mfussenegger/nvim-jdtls"

  -- typescript
  use "jose-elias-alvarez/typescript.nvim"

  -- (auto)completion {{{1
  -- snippets {{{2
  -- snippet engine
  use "L3MON4D3/LuaSnip"

  -- bridge the gap between LuaSnip and nvim-cmp
  use "saadparwaiz1/cmp_luasnip"

  -- nvim-cmp {{{2
  -- autocompletion framework
  use "hrsh7th/nvim-cmp"

  -- cmp LSP source
  use "hrsh7th/cmp-nvim-lsp"

  -- cmp buffer source
  use "hrsh7th/cmp-buffer"

  -- cmp path source
  use "hrsh7th/cmp-path"

  -- git sources
  use { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" }

  -- cmp path source
  use "hrsh7th/cmp-cmdline"

  -- debugging plugins {{{1
  use "puremourning/vimspector"

  -- linter plugins {{{1
  -- Asynchronous Lint Engine brings linting for a lot of file types, when
  -- linter is installed
  use "dense-analysis/ale"

  -- syntax plugins {{{1
  -- treesitter {{{2
  -- treesitter itself
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- helps with analysing the treesitter tree
  use "nvim-treesitter/playground"

  -- show the context of the current function up top
  use "romgrk/nvim-treesitter-context"

  -- }}}2

  -- maven syntax
  use "NLKNguyen/vim-maven-syntax"

  -- colored highlighting for CSS like hex color values
  use "norcalli/nvim-colorizer.lua"

  -- a lot of helpful things dealing with CSV
  use "chrisbra/csv.vim"

  -- better folding for python
  use "tmhedberg/SimpylFold"

  -- File tree {{{1
  -- provides a better file browser than built-in netrw
  use "kyazdani42/nvim-tree.lua"

  -- NERDTree plugins {{{1
  -- provides a better file browser than built-in netrw
  -- use 'preservim/nerdtree'

  -- shows git file status in NERDTree
  -- use { 'Xuyuanp/nerdtree-git-plugin' }

  -- colored file type icons in NERDTree
  -- use { 'tiagofumo/vim-nerdtree-syntax-highlight' }

  -- Airline plugins {{{1
  -- pretty, segmented and configurable status line
  use "vim-airline/vim-airline"

  -- devicons plugins {{{1
  -- dev icons for vimscript plugins
  use "ryanoasis/vim-devicons"

  -- dev icons for lua plugins
  use "kyazdani42/nvim-web-devicons"

  -- dev icons for LSP completion
  use "onsails/lspkind.nvim"

  -- git plugins {{{1
  -- show git line status in gutter
  use "mhinz/vim-signify"

  -- provide integrated git handling in the editor
  use "tpope/vim-fugitive"

  -- movement and editing plugins {{{1
  -- makes motion through words more granular
  use "chaoren/vim-wordmotion"

  -- adds a focus mode to vim
  use "folke/zen-mode.nvim"

  -- adds highlighting of only the local scope
  use { "folke/twilight.nvim", requires = { "nvim-treesitter/nvim-treesitter" } }

  -- adds table formatting commands
  use "godlygeek/tabular"

  -- various handling of variants of words
  -- I mainly use it for the case coercion
  use "tpope/vim-abolish"

  -- toggle line commenting with a key map
  use "tpope/vim-commentary"

  -- automatically add ending pairs of characters or words
  use "tpope/vim-endwise"

  -- makes a lot of Tim Pope's plugins repeatable
  use "tpope/vim-repeat"

  -- add ability to use Ctrl-A/X to manipulate dates
  use "tpope/vim-speeddating"

  -- add maps and commands to surround stuff
  use "tpope/vim-surround"

  -- lots of maps to toggle options and do stuff around current line
  use "tpope/vim-unimpaired"

  -- fzf plugins {{{1
  -- provides vim integration with fzf
  use "ibhagwan/fzf-lua"

  -- misc plugins {{{1
  -- allows better handling for local vimrc files
  use "embear/vim-localvimrc"

  -- lightning fast markdown preview in browser
  use { "euclio/vim-markdown-composer", run = "cargo build --release" }

  -- a scratchpad for lua
  use "rafcamlet/nvim-luapad"
  -- }}}1
end)
