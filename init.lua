-- vim: foldmethod=marker foldlevelstart=0

local compat = require("system-compat")
local ehandler = require("error-handler").handler

-- colors setup {{{1

-- When on, uses |highlight-guifg| and |highlight-guibg| attributes in the
-- terminal (thus using 24-bit color). Requires a ISO-8613-3 compatible
-- terminal.
--
-- Note: https://bruinsslot.jp/post/how-to-enable-true-color-for-neovim-tmux-and-gnome-terminal/
vim.o.termguicolors = compat.should_enable_termguicolors()

vim.o.background = compat.get_system_background()

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

-- theme settings {{{1

-- Try to set the "material" colorscheme, fall back to "morning".
if vim.o.termguicolors then
  if not xpcall(vim.cmd.colorscheme, ehandler, "material") then
    vim.notify(
      [[Could not load the "material" colorscheme, using "morning" instead.]],
      vim.log.levels.WARN
    )
    vim.cmd [[silent! colorscheme morning]]
  end
else
  vim.cmd [[silent! colorscheme morning]]
end

-- plugins and packages {{{1

-- load plugin infrastructure
xpcall(require, ehandler, "plugin-management")

-- load LSP keymaps
xpcall(require, ehandler, "lsp.attach")

-- general Neovim settings {{{1
-- appearance settings {{{2

-- Customize the built-in signs used by the diagnostics API.
local signs = {
  Error = require("icons").diagnostics.error,
  Warn = require("icons").diagnostics.warn,
  Info = require("icons").diagnostics.info,
  Hint = require("icons").diagnostics.hint,
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
vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"
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
vim.o.guifont = "FiraMono Nerd Font:h10"
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
    azcli = "ps1",
    nswag = "json",
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

-- plugin configurations {{{1

-- ft_sql | really old vimscript plugin, that's shipped by default {{{2

-- set the default completion type to be syntax based
vim.g.omni_sql_default_compl_type = "syntax"

-- disable the plugin creating keymaps by default
vim.g.omni_sql_no_default_maps = 1
