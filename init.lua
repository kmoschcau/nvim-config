-- vim: foldmethod=marker foldlevelstart=0

-- theme settings {{{

vim.o.background = require("system-compat").get_system_background()
vim.cmd.colorscheme "new"

-- }}}

-- plugins and packages {{{

local ehandler = require("error-handler").handler

-- load plugin infrastructure
xpcall(require, ehandler, "plugin-management")

-- setup LSP
xpcall(require, ehandler, "lsp.setup")

-- }}}

-- general Neovim settings {{{

-- diagnostics settings {{{

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

-- }}}

-- Neovim options {{{

vim.o.breakindent = true
vim.opt.breakindentopt = { "list:-1", "min:80", "shift:2", "sbr" }
vim.o.colorcolumn = "+1"
vim.opt.completeopt =
  { "fuzzy", "menu", "menuone", "noinsert", "noselect", "popup" }
vim.o.conceallevel = 2
vim.opt.diffopt:append "hiddenoff"
vim.opt.diffopt:append "linematch:60"
vim.o.expandtab = true
vim.o.exrc = true
vim.opt.fillchars = { diff = " " }
vim.o.foldenable = false
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldtext = "" -- TODO: Find a way to have highlighted fold and info.
vim.o.formatoptions = "cro/qnlj"
vim.o.guicursor = table.concat(
  vim.tbl_map(function(pair)
    return table.concat(pair, ":")
  end, {
    { "n", "block-blinkwait1000-blinkon500-blinkoff500-Cursor" },
    { "v", "block-blinkon0-Cursor" },
    { "c", "ver20-blinkwait1000-blinkon500-blinkoff500-Cursor" },
    { "i-ci-sm", "ver20-blinkwait1000-blinkon500-blinkoff500-CursorInsert" },
    { "r-cr", "hor10-blinkwait1000-blinkon500-blinkoff500-CursorReplace" },
    { "o", "hor50-Cursor" },
  }),
  ","
)
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
vim.opt.spellfile = {
  vim.fs.normalize "~/.config/nvim/spell/en.utf-8.add",
  vim.fs.normalize "~/.config/nvim/spell/techspeak.utf-8.add",
}
-- TODO: Look at 'spelloptions'.
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true

-- statusline {{{
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

-- }}}

vim.o.textwidth = 80
vim.o.title = true
vim.o.updatetime = 100
vim.opt.wildoptions:append "fuzzy"

-- }}}

-- autocommands {{{

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
    vim.opt_local.colorcolumn = { "" }
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
  end,
})

-- }}}

-- file type detection {{{

vim.filetype.add {
  extension = {
    azcli = "ps1",
    gotmpl = "gotmpl",
    log = "log",
    nswag = "json",
    rasi = "rasi",
    tfvars = "hcl",
  },
  filename = {
    crypttab = "fstab",
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.yaml"] = "helm",
    ["helmfile.*%.yaml"] = "helm",
  },
}

-- }}}

-- key maps {{{

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

-- }}}}}}

-- neovide settings {{{

if vim.g.neovide then
  -- options {{{

  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_theme = "auto"
  vim.g.neovide_cursor_vfx_mode = "railgun"

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
vim.g.omni_sql_default_compl_type = "syntax"

-- disable the plugin creating keymaps by default
vim.g.omni_sql_no_default_maps = 1

-- }}}

-- ft_markdown | markdown plugin, that's shipped by default {{{

-- Do not let the filetype plugin overwrite formatting settings.
vim.g.markdown_recommended_style = 0

-- }}}}}}
