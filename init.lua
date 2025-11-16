-- vim: foldmethod=marker foldlevelstart=0

-- global variables {{{

-- This is a temporary workaround to prevent highlight flickering.
-- See: https://github.com/neovim/neovim/issues/32660
vim.g._ts_force_sync_parsing = true

-- }}}

-- theme settings {{{

vim.o.background = require("kmo.system-compat").get_system_background()
vim.cmd.colorscheme "new"

-- }}}

-- plugins and packages {{{

local error_handler = require("kmo.error-handler").handler

-- load plugin infrastructure
xpcall(require, error_handler, "kmo.plugin-management")

-- setup LSP
xpcall(require, error_handler, "kmo.lsp")

-- }}}

-- configuration modules {{{

xpcall(require, error_handler, "kmo.diagnostics")
xpcall(require, error_handler, "kmo.extui")
xpcall(require, error_handler, "kmo.filetype")
xpcall(require, error_handler, "kmo.treesitter")
xpcall(require, error_handler, "terminal")

-- }}}

-- general Neovim settings {{{

-- Neovim options {{{

local opt_sym = require("kmo.symbols").options

vim.o.breakindent = true
vim.opt.breakindentopt = { "list:-1", "min:80", "shift:2", "sbr" }
vim.o.colorcolumn = "+1"
vim.opt.comments:remove "n:>"
vim.opt.comments:remove ":XCOMM" -- cspell:disable-line
vim.opt.comments:remove ":%"
vim.opt.completefuzzycollect = { "files", "keyword", "whole_line" }
vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert", "fuzzy" }
vim.o.conceallevel = 2
vim.opt.diffopt:append "algorithm:histogram"
vim.opt.diffopt:append "anchor"
vim.opt.diffopt:append "hiddenoff"
vim.opt.diffopt:append "indent-heuristic"
vim.opt.diffopt:remove "inline:simple"
vim.opt.diffopt:append "inline:word"
vim.opt.diffopt:append "linematch:60"
vim.o.expandtab = true
vim.o.exrc = true
vim.opt.fillchars = opt_sym.fillchars
vim.o.foldenable = false
vim.o.formatoptions = "cro/qnlj" -- cspell:disable-line
vim.o.guicursor = table.concat(
  vim.tbl_map(function(pair)
    return table.concat(pair, ":")
  end, {
    { "n-t", "block-blinkwait1000-blinkon500-blinkoff500-Cursor" },
    { "v", "block-blinkon0-Cursor" },
    { "c", "ver20-blinkwait1000-blinkon500-blinkoff500-Cursor" },
    { "i-ci-sm", "ver20-blinkwait1000-blinkon500-blinkoff500-CursorInsert" },
    { "r-cr", "hor10-blinkwait1000-blinkon500-blinkoff500-CursorReplace" },
    { "o", "hor50-Cursor" },
  }),
  ","
)
local base_font = "FiraMono Nerd Font" -- cspell:disable-line
if vim.fn.has "win32" == 1 then
  vim.o.guifont = table.concat(
    { base_font, "Segoe UI Emoji", "Unifont Upper" }, -- cspell:disable-line
    ","
  ) .. ":h10"
else
  vim.o.guifont = base_font .. ":h10"
end
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.linebreak = true
vim.o.list = true
vim.opt.listchars = opt_sym.listchars
vim.o.mouse = "a"
vim.o.mousemodel = "extend"
vim.o.number = true
vim.o.scrolljump = -50

require("kmo.system-compat").set_up_shell()

vim.o.shiftwidth = 2
vim.o.showbreak = opt_sym.showbreak
vim.o.showmode = false
vim.o.sidescrolloff = 10
-- cspell:disable-next-line
if pcall(require, "statuscol") then
  vim.o.signcolumn = "number"
else
  vim.o.signcolumn = "yes:2"
end
vim.o.smartcase = true
vim.o.smarttab = false
vim.o.smoothscroll = true
vim.o.spell = true
vim.opt.spellfile = {
  vim.fs.normalize "~/.config/nvim/spell/en.utf-8.add",
  -- cspell:disable-next-line
  vim.fs.normalize "~/.config/nvim/spell/techspeak.utf-8.add",
}
vim.opt.spelloptions = { "camel" }
vim.o.splitbelow = true
vim.o.splitright = true

-- statusline {{{
-- selene: allow(unused_variable)

---Convert the current mode from `vim.fn.mode()` into a readable string.
---@return string
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
  .. opt_sym.statusline.line
  .. ":%l/%L "
  -- Column number and virtual column number, if different; minimum 5
  .. opt_sym.statusline.column
  .. ":%5(%c%V%) "

-- }}}

vim.o.textwidth = 80
vim.o.title = true
vim.o.undofile = true
vim.o.updatetime = 100
vim.opt.wildoptions:append "fuzzy"
vim.o.winborder = "rounded"

-- }}}

-- autocommands {{{

local augroup = vim.api.nvim_create_augroup("InitNvim", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text after yanking.",
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- }}}

-- user commands {{{

-- shell {{{

vim.api.nvim_create_user_command("SetUpShell", function(args)
  require("kmo.system-compat").set_up_shell(args.bang)
end, {
  bang = true,
  bar = true,
  desc = "Shell: Set up shell, bang resets to default.",
})

-- }}}}}}

-- key maps {{{

-- formatoptions toggles
vim.keymap.set("n", "[Fa", function()
  vim.opt_local.formatoptions:append "a"
end, { desc = "Formatoptions: Enable automatic paragraph formatting." })

vim.keymap.set("n", "]Fa", function()
  vim.opt_local.formatoptions:remove "a"
end, { desc = "Formatoptions: Disable automatic paragraph formatting." })

-- highlight group inspection
vim.keymap.set("n", "<F10>", function()
  vim.show_pos()
end, { desc = "Syntax: Show highlight group information at cursor position." })

vim.keymap.set("n", "<F22>", function()
  vim.treesitter.inspect_tree()
end, { desc = "Treesitter: Show tree inspection window." })

-- }}}}}}

-- neovide settings {{{

if vim.g.neovide then
  -- options {{{

  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_vfx_mode = "railgun" -- cspell:disable-line
  vim.g.neovide_floating_corner_radius = 0.2
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_theme = "auto"

  if vim.fn.has "mac" == 1 then
    vim.g.neovide_normal_opacity = 0.8
    vim.g.neovide_transparency = 1
    vim.g.neovide_window_blurred = true
  end

  -- }}}

  -- scaling {{{

  vim.g.neovide_scale_factor = 1.0

  vim.keymap.set("n", "<C-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1 / 1.25
  end, {
    desc = "Neovide: Scale down.",
  })

  vim.keymap.set("n", "<C-+>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.25
  end, {
    desc = "Neovide: Scale up.",
  })

  vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, {
    desc = "Neovide: Reset scaling.",
  })

  -- }}}

  -- fullscreen {{{

  vim.keymap.set("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end)

  -- }}}
end

-- }}}

-- plugin configurations {{{

-- ft_sql | really old vimscript plugin, that's shipped by default {{{

-- set the default completion type to be syntax based
vim.g.omni_sql_default_compl_type = "syntax" -- cspell:disable-line

-- disable the plugin creating keymaps by default
vim.g.omni_sql_no_default_maps = 1

-- }}}

-- ft_markdown | markdown plugin, that's shipped by default {{{

-- Do not let the filetype plugin overwrite formatting settings.
vim.g.markdown_recommended_style = 0

-- }}}}}}
