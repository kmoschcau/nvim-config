-- vim: foldmethod=marker foldlevelstart=0

-- global types {{{

--- @class EventArgs
--- @field id number autocommand id
--- @field event string name of the triggered event
--- @field group number | nil autocommand group id, if any
--- @field file string \<afile> (not expanded to a full path)
--- @field match string \<amatch> (expanded to a full path)
--- @field buf number \<abuf>
--- @field data any arbitrary data passed from nvim_exec_autocmds()

-- }}}

-- global variables {{{

-- Whether to use roslyn and rzls instead of OmniSharp for C#.
vim.g.use_roslyn = false

-- }}}

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
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = require("symbols").diagnostics.severities.error,
      [vim.diagnostic.severity.WARN] = require("symbols").diagnostics.severities.warn,
      [vim.diagnostic.severity.INFO] = require("symbols").diagnostics.severities.info,
      [vim.diagnostic.severity.HINT] = require("symbols").diagnostics.severities.hint,
    },
  },
  float = {
    source = true,
  },
  severity_sort = true,
}

-- }}}

-- Neovim options {{{

vim.o.breakindent = true
vim.opt.breakindentopt = { "list:-1", "min:80", "shift:2", "sbr" }
vim.o.colorcolumn = "+1"
vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert", "fuzzy" }
vim.o.conceallevel = 2
vim.opt.diffopt:append "hiddenoff"
vim.opt.diffopt:append "linematch:60"
vim.o.expandtab = true
vim.o.exrc = true
vim.opt.fillchars = require("symbols").fillchars
vim.o.foldenable = false
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldtext = "" -- TODO: Find a way to have highlighted fold and info.
vim.o.formatoptions = "cro/qnlj"
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

require("system-compat").set_up_shell()

vim.o.shiftwidth = 2
vim.o.showbreak = "↪ "
vim.o.showmode = false
vim.o.sidescrolloff = 10
if pcall(require, "statuscol") then
  vim.o.signcolumn = "number"
else
  vim.o.signcolumn = "auto:2-9"
end
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
vim.o.undofile = true
vim.o.updatetime = 100
vim.opt.wildoptions:append "fuzzy"

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

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Adjust settings to make more sense in a terminal.",
  group = augroup,
  callback = function()
    vim.opt_local.colorcolumn = { "" }
    vim.opt_local.spell = false
  end,
})

-- }}}

-- file type detection {{{

vim.filetype.add {
  extension = {
    azcli = "ps1",
    gotmpl = "gotmpl",
    nswag = "json",
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.yaml"] = "helm",
    ["helmfile.*%.yaml"] = "helm",
  },
}

-- }}}

-- user commands {{{

-- diagnostics {{{

vim.api.nvim_create_user_command("HighlightSeverity", function(args)
  local argument = args.fargs[1]
  local severity = vim.diagnostic.severity[argument]
  if not severity then
    vim.notify(
      "An invalid argument was provided: " .. argument,
      vim.log.levels.ERROR,
      { title = args.name }
    )
    return
  end

  vim.diagnostic.config {
    underline = { severity = { min = severity } },
    virtual_text = { severity = { min = severity } },
  }
end, {
  bar = true,
  complete = function()
    local candidates = {}

    for key, _ in pairs(vim.diagnostic.severity) do
      candidates[#candidates + 1] = key
    end

    return candidates
  end,
  desc = "Diagnostics: Set the minimum severity level of in-buffer diagnostics",
  nargs = 1,
})

-- }}}

-- shell {{{

vim.api.nvim_create_user_command("SetUpShell", function(args)
  require("system-compat").set_up_shell(args.bang)
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

-- diagnostics
vim.keymap.set("n", "<Space>L", vim.diagnostic.setloclist, {
  desc = "Diagnostics: Put all buffer diagnostics in the location list.",
})

vim.keymap.set("n", "<Space>le", function()
  vim.diagnostic.setloclist {
    severity = { min = vim.diagnostic.severity.ERROR },
    title = "Error diagnostics",
  }
end, {
  desc = "Diagnostics: Put all buffer error diagnostics in the location list.",
})

vim.keymap.set("n", "<Space>lw", function()
  vim.diagnostic.setloclist {
    severity = { min = vim.diagnostic.severity.WARN },
    title = "Warning and higher diagnostics",
  }
end, {
  desc = "Diagnostics: Put all buffer warning and higher diagnostics in the location list.",
})

vim.keymap.set("n", "<Space>li", function()
  vim.diagnostic.setloclist {
    severity = { min = vim.diagnostic.severity.INFO },
    title = "Info and higher diagnostics",
  }
end, {
  desc = "Diagnostics: Put all buffer info and higher diagnostics in the location list.",
})

vim.keymap.set("n", "<Space>Q", vim.diagnostic.setqflist, {
  desc = "Diagnostics: Put all project diagnostics in the quickfix list.",
})

vim.keymap.set("n", "<Space>qe", function()
  vim.diagnostic.setqflist {
    severity = { min = vim.diagnostic.severity.ERROR },
    title = "Error diagnostics",
  }
end, {
  desc = "Diagnostics: Put all project error diagnostics in the quickfix list.",
})

vim.keymap.set("n", "<Space>qw", function()
  vim.diagnostic.setqflist {
    severity = { min = vim.diagnostic.severity.WARN },
    title = "Warning and higher diagnostics",
  }
end, {
  desc = "Diagnostics: Put all project warning and higher diagnostics in the quickfix list.",
})

vim.keymap.set("n", "<Space>qi", function()
  vim.diagnostic.setqflist {
    severity = { min = vim.diagnostic.severity.INFO },
    title = "Info and higher diagnostics",
  }
end, {
  desc = "Diagnostics: Put all project info and higher diagnostics in the quickfix list.",
})

-- highlight group inspection
vim.keymap.set("n", "<F10>", vim.show_pos, {
  desc = "Syntax: Show highlight group information at cursor position.",
})

vim.keymap.set("n", "<S-F10>", vim.treesitter.inspect_tree, {
  desc = "Treesitter: Show tree inspection window.",
})

-- }}}}}}

-- neovide settings {{{

if vim.g.neovide then
  -- options {{{

  vim.g.neovide_cursor_vfx_mode = "railgun"
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
vim.g.omni_sql_default_compl_type = "syntax"

-- disable the plugin creating keymaps by default
vim.g.omni_sql_no_default_maps = 1

-- }}}

-- ft_markdown | markdown plugin, that's shipped by default {{{

-- Do not let the filetype plugin overwrite formatting settings.
vim.g.markdown_recommended_style = 0

-- }}}}}}
