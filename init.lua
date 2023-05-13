-- vim: foldmethod=marker foldlevelstart=0

-- colors setup {{{1

-- When on, uses |highlight-guifg| and |highlight-guibg| attributes in the
-- terminal (thus using 24-bit color). Requires a ISO-8613-3 compatible
-- terminal.
--
-- Note: https://bruinsslot.jp/post/how-to-enable-true-color-for-neovim-tmux-and-gnome-terminal/
local terminfo_colors
if vim.fn.has "unix" > 0 then
  terminfo_colors = vim.trim(vim.fn.system "tput colors")
else
  if vim.fn.exists "$WT_SESSION" > 0 then
    terminfo_colors = "256"
  else
    terminfo_colors = ""
  end
end
if terminfo_colors:match "256" then
  vim.o.termguicolors = true
end

-- path settings {{{1

-- set the paths for python executables
local python_path
if vim.fn.has "win32" > 0 then
  python_path = vim.fs.normalize "C:/Python37/python"
else
  python_path = vim.fs.normalize "~/.pyenv/versions/neovim3/bin/python"
end
if vim.fn.executable(python_path) > 0 then
  vim.g.python3_host_prog = python_path
end

-- plugins and packages {{{1
local ehandler = require("error-handler").handler

-- bootstrap packer
xpcall(require, ehandler, "packer.bootstrap")

-- load plugin list
xpcall(require, ehandler, "plugins")

-- load the plugin configuration files
xpcall(require, ehandler, "plugins.config")

-- general Neovim settings {{{1
-- appearance settings {{{2
-- colorscheme settings {{{3

vim.o.background = "light"

-- Try to set the "material" colorscheme, fall back to "morning".
if vim.o.termguicolors then
  if not pcall(function()
    vim.cmd.colorscheme "material"
  end) then
    vim.notify(
      [[Could not load the "material" colorscheme, using "morning" instead.]],
      vim.log.levels.WARN
    )
    vim.cmd [[silent! colorscheme morning]]
  end
else
  vim.cmd [[silent! colorscheme morning]]
end

-- Sign settings {{{3

-- Customize the built-in signs used by the diagnostics API.
local signs = {
  Error = require("icons").error,
  Warn = require("icons").warn,
  Info = require("icons").info,
  Hint = require("icons").hint,
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Neovim options {{{2

vim.o.breakindent = true
vim.o.breakindentopt = "min:80,shift:2,sbr"
vim.o.colorcolumn = "+1"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
vim.opt.diffopt:append "hiddenoff"
vim.opt.diffopt:append "linematch:60"
vim.o.expandtab = true
vim.o.exrc = true
vim.opt.fillchars = { diff = " " }
vim.o.foldenable = false
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"
vim.o.formatoptions = "cro/qnlj"
vim.o.guicursor = table.concat({
  table.concat({
    "n",
    "block-blinkwait1000-blinkon500-blinkoff500-Cursor",
  }, ":"),
  table.concat({
    "v",
    "block-blinkon0-Cursor",
  }, ":"),
  table.concat({
    "c",
    "ver20-blinkwait1000-blinkon500-blinkoff500-Cursor",
  }, ":"),
  table.concat({
    "i-ci-sm",
    "ver20-blinkwait1000-blinkon500-blinkoff500-CursorInsert",
  }, ":"),
  table.concat({
    "r-cr",
    "hor10-blinkwait1000-blinkon500-blinkoff500-CursorReplace",
  }, ":"),
  table.concat({
    "o",
    "hor50-Cursor",
  }, ":"),
}, ",")
vim.o.guifont = "FuraMonoNerdFontComplete:h10"
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
  nbsp = "⨯",
}
vim.o.mouse = "a"
vim.o.mousemodel = "extend"
vim.o.number = true
vim.o.shiftwidth = 2
vim.opt.shortmess:append "I"
vim.o.showbreak = "↪ "
vim.o.showmode = false
vim.o.signcolumn = "auto:2"
vim.o.smarttab = false
vim.o.splitbelow = true
vim.o.splitright = true

-- statusline {{{3
-- selene: allow(unused_variable)

--- Convert the current mode from `vim.fn.mode()` into a readable string.
--- @return string
function StatuslineModeName()
  return ({
    n = "NORMAL",
    no = "N-OPERATOR PENDING",
    v = "VISUAL",
    V = "V-LINE",
    [""] = "V-BLOCK",
    s = "SELECT",
    S = "S-LINE",
    [""] = "S-BLOCK",
    i = "INSERT",
    R = "REPLACE",
    Rv = "V-REPLACE",
    c = "COMMAND",
    cv = "VIM EX",
    ce = "EX",
    r = "PROMPT",
    rm = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    t = "TERMINAL",
  })[vim.fn.mode()]
end

vim.o.statusline =
  -- show the current mode
  -- left justified, minimum 7
  " %-7.{v:lua.StatuslineModeName()}"
  -- group for buffer flags
  -- %h: Help buffer flag, text is "[help]".
  -- %w: Preview window flag, text is "[Preview]".
  -- %q: "[Quickfix List]", "[Location List]" or empty.
  -- left justified
  .. " %h%w%q"
  -- Path to the file in the buffer, as typed or relative to current directory
  -- left justified, maximum 100
  .. " %.100f"
  -- group for modification flags
  -- Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
  .. " %m%r"
  -- Separation point between alignment sections. Each section will be separated
  -- by an equal number of spaces. No width fields allowed.
  .. "%="
  -- Type of file in the buffer, e.g., "[vim]".  See 'filetype'.
  -- maximum 20
  .. "%.20y "
  -- Percentage through file in lines as in CTRL-G.
  -- minimum 3, followed by a literal percent sign
  .. "%3p%% "
  -- %l: Line number.
  -- %L: Number of lines in buffer.
  .. ":%l/%L☰ "
  -- Column number and virtual column number, if different.
  -- preceded by a literal ': ', minimum 5
  .. "℅:%5(%c%V%) "
-- }}}3

vim.o.textwidth = 80
vim.o.title = true
vim.o.updatetime = 100

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
  end,
})

-- file type detection {{{2

vim.filetype.add {
  extension = {
    rasi = "rasi",
  },
  filename = {
    crypttab = "fstab",
  },
}

-- key maps {{{2

-- diagnostics API bindings
vim.keymap.set("n", "<space>e", function()
  vim.diagnostic.open_float { border = "rounded" }
end, {
  desc = "Open the floating window for the diagnostic closest to the cursor.",
  silent = true,
})
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev { float = { border = "rounded" } }
end, {
  desc = "Go to the previous diagnostic from the cursor.",
  silent = true,
})
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next { float = { border = "rounded" } }
end, {
  desc = "Go to the next diagnostic from the cursor.",
  silent = true,
})
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, {
  desc = "Put all buffer diagnostics in the location list.",
  silent = true,
})

-- highlight group inspection
vim.keymap.set("n", "<F10>", vim.show_pos, {
  desc = "Show syntax highlight group information at cursor position.",
  silent = true,
})

-- plugin key maps {{{3
-- vim-wordmotion | chaoren/vim-wordmotion {{{4

-- Change the wordmotion keys to work with Alt.
vim.g.wordmotion_mappings = {
  w = "<M-w>",
  b = "<M-b>",
  e = "<M-e>",
  ge = "g<M-e>",
  aw = "g<M-w>",
  iw = "g<M-w>",
}

-- plugin configurations {{{1

-- csv.vim | chrisbra/csv.vim {{{2

vim.g.csv_no_conceal = 1

-- packer.nvim | wbthomason/packer.nvim {{{2

local packer_augroup = vim.api.nvim_create_augroup("PackerNvim_InitVim", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Automatically source the plugin configuration on write.",
  group = packer_augroup,
  pattern = vim.fs.normalize "~/.config/nvim/lua/plugins/init.lua",
  callback = function()
    vim.notify("Reloaded plugins init", vim.log.levels.DEBUG)
    package.loaded["plugins"] = nil
    xpcall(require, ehandler, "plugins")
  end,
})

-- vim-markdown-composer | euclio/vim-markdown-composer {{{2

-- Whether the server should automatically start when a markdown file is opened.
vim.g.markdown_composer_autostart = 0

-- Add additional logic for WSL
if vim.fn.executable "xdg-open" > 0 then
  vim.g.markdown_composer_browser = "xdg-open"
elseif vim.fn.executable "wslview" > 0 then
  vim.g.markdown_composer_browser = "wslview"
end

-- ft_sql | really old vimscript plugin, that's shipped by default {{{2

-- set the default completion type to be syntax based
vim.g.omni_sql_default_compl_type = "syntax"

-- disable the plugin creating keymaps by default
vim.g.omni_sql_no_default_maps = 1
