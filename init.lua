-- vim: foldmethod=marker foldlevel=0

-- value used for pumblend and winblend
local window_blend = 20

-- colors setup {{{1

-- When on, uses |highlight-guifg| and |highlight-guibg| attributes in the
-- terminal (thus using 24-bit color). Requires a ISO-8613-3 compatible
-- terminal.
--
-- Note: https://bruinsslot.jp/post/how-to-enable-true-color-for-neovim-tmux-and-gnome-terminal/
local terminfo_colors
if vim.fn.has("unix") > 0 then
  terminfo_colors = vim.trim(vim.fn.system("tput colors"))
else
  if vim.fn.exists("$WT_SESSION") > 0 then
    terminfo_colors = "256"
  else
    terminfo_colors = ""
  end
end
if terminfo_colors:match("256") then
  vim.o.termguicolors = true
end

-- path settings {{{1

-- set the paths for python executables
local python_path
if vim.fn.has("win32") > 0 then
  python_path = vim.fn.expand("C:/Python37/python")
else
  python_path = vim.fn.expand("$HOME/.pyenv/versions/neovim3/bin/python")
end
if vim.fn.executable(python_path) > 0 then
  vim.g.python3_host_prog = python_path
end

-- plugins and packages {{{1
-- bootstrap packer
require "packer.bootstrap"

-- load the plugin configuration files
require "plugins.config"

-- general Neovim settings {{{1
-- appearance settings {{{2
-- colorscheme settings {{{3

-- When set to "dark", Vim will try to use colors that look good on a dark
-- background.  When set to "light", Vim will try to use colors that look good
-- on a light background.
vim.o.background = "light"

-- Try to set the "material" colorscheme, fall back to "morning".
if vim.o.termguicolors then
  if not pcall(function() vim.cmd [[colorscheme material]] end) then
    vim.notify(
      [[Could not load the "material" colorscheme, using "morning" instead.]],
      3)
    vim.cmd [[silent! colorscheme morning]]
  end
else
  vim.cmd [[silent! colorscheme morning]]
end

-- Sign settings {{{3

-- Customize the built-in signs used by the diagnostics API.
local signs = {
  Error = require("icons").error,
  Warn  = require("icons").warn,
  Info  = require("icons").info,
  Hint  = require("icons").hint
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Neovim options {{{2

vim.o.breakindent = true
vim.o.breakindentopt = "min:80,shift:2,sbr"
vim.o.colorcolumn = "+1"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
vim.o.equalalways = false
vim.o.expandtab = true
vim.opt.fillchars = { diff = " " }
vim.o.foldlevelstart = 99
vim.o.formatoptions = "cro/qlj"
vim.o.guicursor = table.concat({
  table.concat({
    "n",
    "block-blinkwait1000-blinkon500-blinkoff500-Cursor"
  }, ":"),
  table.concat({
    "v",
    "block-blinkon0-Cursor"
  }, ":"),
  table.concat({
    "c",
    "ver20-blinkwait1000-blinkon500-blinkoff500-Cursor"
  }, ":"),
  table.concat({
    "i-ci-sm",
    "ver20-blinkwait1000-blinkon500-blinkoff500-CursorInsert"
  }, ":"),
  table.concat({
    "r-cr",
    "hor10-blinkwait1000-blinkon500-blinkoff500-CursorReplace"
  }, ":"),
  table.concat({
    "o",
    "hor50-Cursor"
  }, ":")
}, ",")
vim.o.guioptions = "cig"
vim.o.inccommand = "split"
vim.o.linebreak = true
vim.o.list = true
vim.opt.listchars = {
  tab = "⊳ ⎹",
  trail = "·",
  extends = "≻",
  precedes = "≺",
  conceal = "◌",
  nbsp = "⨯"
}
vim.o.mouse = "a"
vim.o.mousemodel = "extend"
vim.o.number = true
vim.o.pumblend = window_blend
vim.o.shiftwidth = 2
vim.opt.shortmess:append "I"
vim.o.showbreak = "↪ "
vim.o.showmode = false
vim.o.signcolumn = "auto:2"
vim.o.smarttab = false
vim.o.splitbelow = true
vim.o.splitright = true

-- statusline {{{3
function StatuslineModeName()
  return ({
    n      = "NORMAL",
    no     = "N-OPERATOR PENDING",
    v      = "VISUAL",
    V      = "V-LINE",
    [""]  = "V-BLOCK",
    s      = "SELECT",
    S      = "S-LINE",
    [""]  = "S-BLOCK",
    i      = "INSERT",
    R      = "REPLACE",
    Rv     = "V-REPLACE",
    c      = "COMMAND",
    cv     = "VIM EX",
    ce     = "EX",
    r      = "PROMPT",
    rm     = "MORE",
    ["r?"] = "CONFIRM",
    ["!"]  = "SHELL",
    t      = "TERMINAL"
  })[vim.fn.mode()]
end

vim.o.statusline =
-- show the current mode
-- left justified, minimum 7
" %-7.{v:lua.StatuslineModeName()}" ..

    -- group for buffer flags
    -- %h: Help buffer flag, text is "[help]".
    -- %w: Preview window flag, text is "[Preview]".
    -- %q: "[Quickfix List]", "[Location List]" or empty.
    -- left justified
    " %h%w%q" ..

    -- Path to the file in the buffer, as typed or relative to current directory
    -- left justified, maximum 100
    " %.100f" ..

    -- group for modification flags
    -- Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
    " %m%r" ..

    -- Separation point between alignment sections. Each section will be separated
    -- by an equal number of spaces. No width fields allowed.
    "%=" ..

    -- Type of file in the buffer, e.g., "[vim]".  See 'filetype'.
    -- maximum 20
    "%.20y " ..

    -- Percentage through file in lines as in CTRL-G.
    -- minimum 3, followed by a literal percent sign
    "%3p%% " ..

    -- %l: Line number.
    -- %L: Number of lines in buffer.
    ":%l/%L☰ " ..

    -- Column number and virtual column number, if different.
    -- preceded by a literal ': ', minimum 5
    "℅:%5(%c%V%) "
-- }}}3

vim.o.textwidth = 80
vim.o.title = true
vim.o.updatetime = 100
vim.o.winblend = window_blend

-- autocommands {{{2

local augroup = vim.api.nvim_create_augroup("InitVim", {})
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Remove all columns from terminal buffers.",
  group = augroup,
  callback = function()
    vim.api.nvim_set_option_value("colorcolumn", "", { scope = "local" })
    vim.api.nvim_set_option_value("number", false, { scope = "local" })
    vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
    vim.api.nvim_set_option_value("signcolumn", "no", { scope = "local" })
  end
})

-- key maps {{{2

-- diagnostics API bindings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { silent = true })

-- highlight group inspection
vim.keymap.set(
  "n",
  "<F10>",
  function()
    if not (vim.fn.exists("*synstack") > 0) then
      return
    end

    if vim.fn.exists(":TSHighlightCapturesUnderCursor") > 0 then
      vim.cmd [[TSHighlightCapturesUnderCursor]]
      return
    end

    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    local names = {}
    for _, id in ipairs(vim.fn.synstack(line, col)) do
      table.insert(names, vim.fn.synIDattr(id, "name"))
    end
    print(vim.inspect(names))
  end,
  {
    desc = "Show syntax highlight group information at cursor position.",
    silent = true
  }
)

-- plugin key maps {{{3
-- fzf-lua | ibhagwan/fzf-lua {{{4

vim.keymap.set("n", "<C-p>", ":FzfLua files<cr>", {
  desc = "Open FZF file search.",
  silent = true
})

vim.keymap.set("n", "<C-_>", ":FzfLua live_grep<cr>", {
  desc = "Open FZF fuzzy search.",
  silent = true
})

-- vim-wordmotion | chaoren/vim-wordmotion {{{4

-- Change the wordmotion keys to work with Alt.
vim.g.wordmotion_mappings = {
  w  = "<M-w>",
  b  = "<M-b>",
  e  = "<M-e>",
  ge = "g<M-e>",
  aw = "g<M-w>",
  iw = "g<M-w>"
}

-- vimspector | puremourning/vimspector {{{4

vim.keymap.set("n", "<M-v>c", "<Plug>VimspectorContinue", { remap = true })
vim.keymap.set("n", "<M-v>p", "<Plug>VimspectorPause", { remap = true })
vim.keymap.set("n", "<M-v>s", "<Plug>VimspectorStop", { remap = true })
vim.keymap.set("n", "<M-v>R", ":VimspectorReset<cr>", {})
vim.keymap.set("n", "<M-v>b", "<Plug>VimspectorToggleBreakpoint", {
  remap = true
})
vim.keymap.set("n", "<M-v>B", "<Plug>VimspectorToggleConditionalBreakpoint", {
  remap = true
})
vim.keymap.set("n", "<M-v>r", "<Plug>VimspectorRunToCursor", { remap = true })
vim.keymap.set("n", "<M-v>o", "<Plug>VimspectorStepOver", { remap = true })
vim.keymap.set("n", "<M-v>i", "<Plug>VimspectorStepInto", { remap = true })
vim.keymap.set("n", "<M-v>u", "<Plug>VimspectorStepOut", { remap = true })
vim.keymap.set("n", "<M-v>e", "<Plug>VimspectorBalloonEval", { remap = true })
vim.keymap.set("n", "<M-v>e", "<Plug>VimspectorBalloonEval", { remap = true })

-- plugin configurations {{{1
-- SimpylFold | tmhedberg/SimpylFold {{{2

-- Preview docstrings in fold text.
vim.g.SimpylFold_docstring_preview = 1

-- ale | dense-analysis/ale {{{2

-- This variable defines the format of the echoed message. The `%s` is the error
-- message itself, and it can contain the following handlers:
-- - `%linter%` for linter's name
-- - `%severity%` for the type of severity
vim.g.ale_echo_msg_format = "%linter%: %severity% - %s"

-- The sign for errors in the sign gutter.
vim.g.ale_sign_error = signs.Error

-- The sign for "info" markers in the sign gutter.
vim.g.ale_sign_info = signs.Info

-- The sign for style errors in the sign gutter.
vim.g.ale_sign_style_error = signs.Error

-- The sign for style warnings in the sign gutter.
vim.g.ale_sign_style_warning = signs.Warn

-- The sign for warnings in the sign gutter.
vim.g.ale_sign_warning = signs.Warn

-- Enable the virtualtext error display.
vim.g.ale_virtualtext_cursor = 1

-- csv.vim | chrisbra/csv.vim {{{2

vim.g.csv_no_conceal = 1

-- nvim-treesitter | nvim-treesitter/nvim-treesitter {{{2

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- packer.nvim | wbthomason/packer.nvim {{{2

vim.cmd [[
augroup PackerNvim_InitVim
  autocmd!

  autocmd BufWritePost ~/.config/nvim/lua/plugins/init.lua source <afile> | PackerCompile
augroup end
]]

-- vim-markdown-composer | euclio/vim-markdown-composer {{{2

-- Whether the server should automatically start when a markdown file is opened.
vim.g.markdown_composer_autostart = 0

-- vim-signify | mhinz/vim-signify {{{2

-- Which VCS to check for
vim.g.signify_vcs_list = { "git" }

-- Enable more aggressive sign update.
vim.g.signify_realtime = 1

-- Update signs when entering a buffer that was modified.
vim.g.signify_update_on_bufenter = 1

-- Update the signs on FocusGained.
vim.g.signify_update_on_focusgained = 1

-- Reconfigure the sign text used.
vim.g.signify_sign_change = "~"

-- Additionally trigger sign updates in normal or insert mode after 'updatetime'
-- milliseconds without any keypresses.
vim.g.signify_cursorhold_normal = 1
vim.g.signify_cursorhold_insert = 1
