-- vim: foldmethod=marker foldlevelstart=0

-- theme settings {{{1

vim.o.background = require("system-compat").get_system_background()
vim.cmd.colorscheme "new"

-- plugins and packages {{{1

local ehandler = require("error-handler").handler

-- load plugin infrastructure
xpcall(require, ehandler, "plugin-management")

-- load LSP keymaps
xpcall(require, ehandler, "lsp.attach")

-- general Neovim settings {{{1
-- diagnostics settings {{{2

vim.diagnostic.config {
  float = {
    source = true,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = require("symbols").diagnostics.severities.error,
      [vim.diagnostic.severity.WARN] = require("symbols").diagnostics.severities.warn,
      [vim.diagnostic.severity.INFO] = require("symbols").diagnostics.severities.info,
      [vim.diagnostic.severity.HINT] = require("symbols").diagnostics.severities.hint,
    },
  },
}

-- Neovim options {{{2

vim.o.breakindent = true
vim.o.breakindentopt = "min:80,shift:2,sbr"
vim.opt.colorcolumn = { "+1" }
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
if not pcall(function()
  vim.opt.completeopt:append "popup"
end) then
  vim.notify(
    "\"popup\" is not supported by 'completeopt'.",
    vim.log.levels.INFO,
    { title = "init.lua" }
  )
end
vim.o.conceallevel = 2
vim.opt.diffopt:append "hiddenoff"
vim.opt.diffopt:append "linematch:60"
vim.o.expandtab = true
vim.o.exrc = true
vim.opt.fillchars = { diff = " " }
vim.o.foldenable = false
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldtext = ""
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
vim.o.scrolljump = -50
vim.o.shiftwidth = 2
vim.opt.shortmess:append "I"
vim.o.showbreak = "↪ "
vim.o.showmode = false
vim.o.sidescrolloff = 10
vim.o.signcolumn = "auto:2"
vim.o.smarttab = false
vim.o.smoothscroll = true
vim.o.spell = true
vim.o.spellfile = table.concat({
  vim.fs.normalize "~/.config/nvim/spell/en.utf-8.add",
  vim.fs.normalize "~/.config/nvim/spell/techspeak.utf-8.add",
}, ",")
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
  .. ":%l/%L "
  -- Column number and virtual column number, if different; minimum 5
  .. ":%5(%c%V%) "
-- }}}3

vim.o.textwidth = 80
vim.o.title = true
vim.o.updatetime = 100

-- autocommands {{{2

local augroup = vim.api.nvim_create_augroup("InitNvim", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text after yanking.",
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Adjust settings to make more sense in a terminal.",
  group = augroup,
  callback = function()
    vim.opt_local.colorcolumn = ""
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
  end,
})

-- file type detection {{{2

vim.filetype.add {
  extension = {
    azcli = "ps1",
    nswag = "json",
    rasi = "rasi",
    tfvars = "hcl",
  },
  filename = {
    crypttab = "fstab",
  },
}

-- key maps {{{2

-- formatoptions toggles
vim.keymap.set("n", "[Fa", function()
  vim.opt_local.formatoptions:append "a"
end, { desc = "Formatoptions: Enable automatic paragraph formatting." })
vim.keymap.set("n", "]Fa", function()
  vim.opt_local.formatoptions:remove "a"
end, { desc = "Formatoptions: Disable automatic paragraph formatting." })

-- diagnostics API bindings
vim.keymap.set("n", "<Space>q", vim.diagnostic.setloclist, {
  desc = "Diagnostics: Put all buffer diagnostics in the location list.",
})

-- highlight group inspection
vim.keymap.set("n", "<F10>", vim.show_pos, {
  desc = "Syntax: Show highlight group information at cursor position.",
})
vim.keymap.set("n", "<F22>", vim.treesitter.inspect_tree, {
  desc = "Treesitter: Show tree inspection window.",
})

-- plugin configurations {{{1

-- ft_sql | really old vimscript plugin, that's shipped by default {{{2

-- set the default completion type to be syntax based
vim.g.omni_sql_default_compl_type = "syntax"

-- disable the plugin creating keymaps by default
vim.g.omni_sql_no_default_maps = 1
