local M = {
  debug = {
    breakpoint = {
      normal = " ",
      conditional = " ",
      log = " ",
      rejected = " ",
    },
    current_frame = " ",
  },
  diagnostics = {
    indicator = "■",
    severities = {
      error = " ",
      warn = " ",
      info = " ",
      hint = "󰌵 ",
    },
  },
  files = {
    modified = " ",
    readonly = "",
    unnamed = "",
    newfile = " ",
  },
  git = {
    lines = {
      added = "󰐕",
      deleted = "󰍴",
      modified = "",
      removed = "󰍴",
    },
    files = {
      conflict = " ",
      ignored = " ",
      renamed = " ",
      staged = " ",
      unstaged = "󰄱 ",
      untracked = "",
    },
  },
  log = {
    error = " ",
    warn = " ",
    info = " ",
    debug = " ",
    trace = " ",
  },
  options = {
    fillchars = {
      diff = " ",
    },
    listchars = {
      tab = "⊳ ⎹",
      trail = "·",
      extends = "≻",
      precedes = "≺",
      conceal = "◌",
      nbsp = "⨯",
    },
    showbreak = "↪ ",
    statusline = {
      line = "",
      column = "",
    },
  },
  separators = {
    section = {
      bottom = {
        left = "",
        right = "",
      },
      top = {
        left = "",
        right = "",
      },
    },
    component = {
      bottom = {
        left = "",
        right = "",
      },
      top = {
        left = "",
        right = "",
      },
    },
    hierarchy = {
      right = "",
    },
  },
  signs = {
    term_prompt = " ",
  },
  snippet = {
    choice_virt_text = " ",
    insert_virt_text = "…",
  },
  todo = {
    fix = " ",
    todo = " ",
    hack = " ",
    warn = " ",
    perf = " ",
    note = " ",
    test = "⏲ ",
  },
  types = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰆧 ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = "󰀬 ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },
}

M.progress = {
  done = " ",
  spinner = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
  },
}

---Gets a dynamic spinner at the current time. This can be called repeatedly to
---create a spinner animation.
---@return string symbol the spinner symbol at the current time
function M.progress.get_dynamic_spinner()
  return M.progress.spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #M.progress.spinner + 1]
end

return M
