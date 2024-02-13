-- vim: foldmethod=marker

-- Setup {{{1
-- NOTE: All manipulation is done in Oklch color space.
-- Get interactive view at https://bottosson.github.io/misc/colorpicker/
-- Install https://github.com/echasnovski/mini.colors to have this working
local success, colors = pcall(require, "mini.colors")
if not success then
  vim.notify("Could not require mini.colors.", vim.log.levels.ERROR)
  return
end

local THEME_NAME = "new"

-- WHETHER TO OPEN A BUFFER WITH DATA
local SHOW_PREVIEW_BUFFER = true

-- WHETHER TO WRITE CONFIGURATION FILES FOR THE SCHEME
local WRITE_COLORSCHEME = true

-- Hyperparameters {{{1

local HUES = {
  pink = 0,
  red = 25,
  amber = 60,
  brown = 60,
  orange = 70,
  yellow = 90,
  green = 150,
  teal = 180,
  cyan = 195,
  seafoam = 220,
  blue = 240,
  grey = 270,
  purple = 300,
  magenta = 330,
}

--- SEMANITC HUE VALUES
--- These are not just hue constants, but associations of semantic objects to
--- hues.
local H = {
  neutral = HUES.grey,
  interact = HUES.cyan,
  modified = HUES.purple,
  search = HUES.yellow,
  messages = HUES.green,
  modes = {
    insert = HUES.blue,
    replace = HUES.amber,
    visual = HUES.cyan,
  },
  diff = {
    add = HUES.green,
    change = HUES.orange,
    delete = HUES.red,
    text = HUES.amber,
  },
  diagnostics = {
    error = HUES.red,
    warn = HUES.orange,
    info = HUES.blue,
    hint = HUES.cyan,
    ok = HUES.green,
    debug = HUES.grey,
    trace = HUES.purple,
  },
  spell = {
    bad = HUES.red,
    cap = HUES.yellow,
    loc = HUES.green,
    rare = HUES.cyan,
  },
  syntax = {
    boolean = HUES.orange,
    ["coroutine"] = HUES.yellow,
    directory = HUES.blue,
    doc_comment = HUES.blue,
    enum = HUES.blue,
    ["function"] = HUES.teal,
    identifier = HUES.green,
    literal = HUES.blue,
    member = HUES.blue,
    metaprogramming = HUES.purple,
    module = HUES.brown,
    number = HUES.blue,
    property = HUES.seafoam,
    special = HUES.red,
    statement = HUES.orange,
    storage_class = HUES.yellow,
    string = HUES.green,
    structure = HUES.green,
    typedef = HUES.green, -- FIXME: think of a better hue for typedef and types
    underlined = HUES.blue,
    variable = HUES.yellow - 10,
  },
}

-- Palettes {{{1

local function convert(l, c, h, opts)
  return colors.convert({ l = l, c = c, h = h }, "hex", {
    gamut_clip = opts and opts.gamut_clip or "chroma",
  })
end

local function make_syn_with_bg(hue)
  return {
    fg = convert(30, 100, hue),
    bg = convert(90, 5, hue),
  }
end

--stylua: ignore
local palette = {
  neutral = {
    max            = convert(100,   0, H.neutral),
    lightest       = convert( 97,   0, H.neutral),
    lighter_still  = convert( 95,   0, H.neutral),
    lighter        = convert( 92,   0, H.neutral),
    light          = convert( 80,   0, H.neutral),
    half_light     = convert( 75,   0, H.neutral),
    mid_light      = convert( 60,   0, H.neutral),
    mid            = convert( 50,   0, H.neutral),
    mid_strong     = convert( 40,   0, H.neutral),
    half_strong    = convert( 25,   0, H.neutral),
    strong         = convert( 20,   0, H.neutral),
    stronger       = convert(  8,   0, H.neutral),
    stronger_still = convert(  5,   0, H.neutral),
    strongest      = convert(  3,   0, H.neutral),
    min            = convert(  0,   0, H.neutral),
  },

  interact = {
    cursor = {
      normal      = convert(70, 100, H.interact),
      non_current = convert(90,   7, H.interact),
      markers     = convert(90,   4, H.interact),
      visual      = convert(90,  10, H.interact),
    },
    statusline = {
      current = convert(70, 100, H.interact),
    },
    modes = {
      insert  = convert(50, 100, H.modes.insert),
      replace = convert(50, 100, H.modes.replace),
      visual  = convert(50, 100, H.modes.visual),
    },
  },

  search = {
    inc     = convert(85, 100, H.search),
    current = convert(90,   7, H.search),
    search  = convert(90,  10, H.search),
  },

  status = {
    modified = convert(50, 100, H.modified),
  },

  diff = {
    add = {
      light  = convert(90,   5, H.diff.add),
      strong = convert(50, 100, H.diff.add),
    },
    change = {
      light  = convert(89,  10, H.diff.change),
      strong = convert(50, 100, H.diff.change),
    },
    delete = {
      light  = convert(85,  10, H.diff.delete),
      strong = convert(50, 100, H.diff.delete),
    },
    text = {
      light = convert(85,  10, H.diff.text),
    },
  },

  diagnostics = {
    error = convert(50, 100, H.diagnostics.error),
    warn  = convert(50, 100, H.diagnostics.warn),
    info  = convert(50, 100, H.diagnostics.info),
    hint  = convert(50, 100, H.diagnostics.hint),
    ok    = convert(50, 100, H.diagnostics.ok),
    debug = convert(50,   0, H.diagnostics.debug),
    trace = convert(50, 100, H.diagnostics.trace),
  },

  lsp = {
    reference = {
      text  = convert(90, 3, HUES.yellow),
      read  = convert(90, 3, HUES.green),
      write = convert(90, 3, HUES.blue),
    },
  },

  spell = {
    bad  = convert(50, 100, H.spell.bad),
    cap  = convert(70, 100, H.spell.cap),
    loc  = convert(70, 100, H.spell.loc),
    rare = convert(70, 100, H.spell.rare),
  },

  messages = {
    mode     = convert(30, 100, H.messages),
    more     = convert(50, 100, H.messages),
    question = convert(50, 100, H.messages),
  },

  syntax = {
    boolean         = make_syn_with_bg(H.syntax.boolean),
    character       = make_syn_with_bg(H.syntax.string - 20),
    comment         = convert(60,   0, H.neutral),
    ["coroutine"]   = convert(70, 100, H.syntax["coroutine"]),
    directory       = convert(60, 100, H.syntax.directory),
    doc_comment     = convert(50,   5, H.syntax.doc_comment),
    enum            = convert(50, 100, H.syntax.enum),
    enum_member     = convert(50, 100, H.syntax.enum),
    event           = convert(50, 100, H.syntax["coroutine"]),
    float           = make_syn_with_bg(H.syntax.number + 20),
    ["function"]    = convert(50, 100, H.syntax["function"]),
    identifier      = convert(70,  10, H.syntax.identifier),
    literal         = make_syn_with_bg(nil),
    member          = convert(60, 100, H.syntax.member),
    metaprogramming = convert(60, 100, H.syntax.metaprogramming),
    module          = convert(30, 100, H.syntax.module),
    number          = make_syn_with_bg(H.syntax.number),
    parameter       = convert(70, 100, H.syntax.variable - 10),
    property        = convert(60, 100, H.syntax.property),
    special         = convert(55,  20, H.syntax.special),
    statement       = convert(70, 100, H.syntax.statement),
    storage_class   = convert(80, 100, H.syntax.storage_class),
    string          = make_syn_with_bg(H.syntax.string),
    structure       = convert(40, 100, H.syntax.structure),
    type            = convert(70, 100, H.syntax.typedef - 20),
    typedef         = convert(60, 100, H.syntax.typedef),
    underlined      = convert(50, 100, H.syntax.underlined),
    variable        = convert(70, 100, H.syntax.variable),
  },

  terminal_colors_light = {
    "#424242",
    "#f44336",
    "#8bc34a",
    "#ff9800",
    "#2196f3",
    "#9c27b0",
    "#009688",
    "#eeeeee",
    "#212121",
    "#d32f2f",
    "#689f38",
    "#f57c00",
    "#1976d2",
    "#7b1fa2",
    "#00796b",
    "#e0e0e0",
  },

  terminal_colors_dark = {
    "#f5f5f5",
    "#ef5350",
    "#9ccc65",
    "#ffa726",
    "#42a5f5",
    "#ab47bc",
    "#26a69a",
    "#616161",
    "#fafafa",
    "#ef9a9a",
    "#c5e1a5",
    "#ffcc80",
    "#90caf9",
    "#ce93d8",
    "#80cbc4",
    "#757575",
  },
}

-- Highlights {{{1

local function invert_l(val)
  return colors.modify_channel(val, "lightness", function(l)
    return 100 - l
  end, { gamut_clip = "lightness" })
end

local function modify_l(val, L)
  return colors.modify_channel(val, "lightness", function(l)
    return l + L
  end, { gamut_clip = "lightness" })
end

local float_normal =
  { fg = palette.neutral.strongest, bg = palette.neutral.max }
local normal =
  { fg = palette.neutral.strongest, bg = modify_l(float_normal.bg, -5) }

--stylua: ignore
local framing = {
  current = {
    normal = { fg = palette.neutral.lightest, bg = palette.interact.statusline.current, bold = true }
  },
  neutral = {
    a       = { fg = normal.fg, bg = modify_l(normal.bg, -20) },
    b       = { fg = normal.fg, bg = modify_l(normal.bg, -10) },
    c       = normal,
    c_no_fg = { fg = modify_l(normal.bg, -20), bg = modify_l(normal.bg, -20) },
  },
}

--- Map a color to a dark background variant.
--- @param val string|table|number|nil
local function map_to_dark(val)
  if val == nil or val == "NONE" then
    return val
  end

  return modify_l(invert_l(val), 20)
end

--stylua: ignore start

--- @type table<string, vim.api.keyset.highlight>
local highlights_light = {
  -- built-in *highlight-groups* {{{2
  ColorColumn   = { bg = modify_l(normal.bg, -5) },
  Conceal       = { fg = palette.neutral.mid_strong },
  CurSearch     = { bg = palette.search.current },
  Cursor        = { bg = palette.interact.cursor.normal },
  lCursor       = { link = "Cursor" },
  CursorColumn  = { link = "CursorLine" },
  CursorLine    = { bg = palette.interact.cursor.markers },
  Directory     = { fg = palette.syntax.directory, bold = true },
  DiffAdd       = { bg = palette.diff.add.light },
  DiffChange    = { bg = palette.diff.change.light },
  DiffDelete    = { bg = palette.diff.delete.light },
  DiffText      = { bg = palette.diff.text.light, bold = true },
  TermCursor    = { link = "Cursor" },
  TermCursorNC  = { bg = palette.interact.cursor.non_current },
  ErrorMsg      = { fg = palette.diagnostics.error },
  WinSeparator  = framing.neutral.c_no_fg,
  Folded        = { fg = modify_l(normal.fg, 50), bg = modify_l(normal.bg, -5) },
  SignColumn    = { link = "LineNr" },
  IncSearch     = { bg = palette.search.inc },
  LineNr        = framing.neutral.b,
  LineNrAbove   = { fg = modify_l(framing.neutral.b.fg, 5), bg = modify_l(framing.neutral.b.bg, 5) },
  LineNrBelow   = { fg = modify_l(framing.neutral.b.fg, -5), bg = modify_l(framing.neutral.b.bg, -5) },
  CursorLineNr  = { fg = framing.neutral.b.fg, bg = palette.interact.cursor.markers },
  MatchParen    = { link = "CursorLine" },
  ModeMsg       = { fg = palette.messages.mode },
  MsgSeparator  = { link = "StatusLineNC" },
  MoreMsg       = { fg = palette.messages.more },
  NonText       = { fg = palette.neutral.light },
  Normal        = normal,
  NormalFloat   = { bg = palette.neutral.max },
  Pmenu         = { link = "NormalFloat" },
  PmenuSel      = { link = "CursorLine" },
  PmenuKindSel  = { link = "Pmenu" },
  PmenuExtraSel = { link = "Pmenu" },
  PmenuSbar     = { bg = palette.neutral.lighter_still },
  PmenuThumb    = { bg = palette.neutral.mid },
  Question      = { fg = palette.messages.more },
  QuickFixLine  = { link = "CursorLine" },
  Search        = { bg = palette.search.search },
  SpecialKey    = { fg = palette.neutral.strong, bg = palette.neutral.lighter, italic = true },
  SpellBad      = { undercurl = true, sp = palette.spell.bad },
  SpellCap      = { undercurl = true, sp = palette.spell.cap },
  SpellLocal    = { undercurl = true, sp = palette.spell.loc },
  SpellRare     = { undercurl = true, sp = palette.spell.rare },
  StatusLine    = framing.current.normal,
  StatusLineNC  = framing.neutral.a,
  TabLine       = { link = "LineNr" },
  TabLineFill   = { link = "StatusLineNC" },
  TabLineSel    = { link = "Normal" },
  Title         = { bold = true },
  Visual        = { bg = palette.interact.cursor.visual },
  WarningMsg    = { fg = palette.diagnostics.warn },
  WinBar        = { link = "StatusLine" },
  WinBarNC      = { link = "StatusLineNC" },

  -- diagnostics *diagnostic-highlights* {{{2

  DiagnosticError = { fg = palette.diagnostics.error },
  DiagnosticWarn  = { fg = palette.diagnostics.warn },
  DiagnosticInfo  = { fg = palette.diagnostics.info },
  DiagnosticHint  = { fg = palette.diagnostics.hint },
  DiagnosticOk    = { fg = palette.diagnostics.ok },

  DiagnosticUnderlineError = { underline = true, sp = palette.diagnostics.error },
  DiagnosticUnderlineWarn  = { underline = true, sp = palette.diagnostics.warn },
  DiagnosticUnderlineInfo  = { underline = true, sp = palette.diagnostics.info },
  DiagnosticUnderlineHint  = { underline = true, sp = palette.diagnostics.hint },
  DiagnosticUnderlineOk    = { underline = true, sp = palette.diagnostics.ok },

  DiagnosticSignError = { fg = palette.diagnostics.error, bg = framing.neutral.b.bg },
  DiagnosticSignWarn  = { fg = palette.diagnostics.warn, bg = framing.neutral.b.bg },
  DiagnosticSignInfo  = { fg = palette.diagnostics.info, bg = framing.neutral.b.bg },
  DiagnosticSignHint  = { fg = palette.diagnostics.hint, bg = framing.neutral.b.bg },
  DiagnosticSignOk    = { fg = palette.diagnostics.ok, bg = framing.neutral.b.bg },

  DiagnosticDeprecated = { strikethrough = true, sp = palette.syntax.comment },

  -- LSP highlights *lsp-highlight* {{{2

  LspReferenceText  = { bg = palette.lsp.reference.text },
  LspReferenceRead  = { bg = palette.lsp.reference.read },
  LspReferenceWrite = { bg = palette.lsp.reference.write },

  LspInlayHint = { fg = palette.neutral.mid_light, bg = palette.neutral.lighter },

  LspCodeLens          = { link = "Comment" },
  LspCodeLensSeparator = { link = "LspCodeLens" },

  LspSignatureActiveParameter = { link = "Search" },

  -- syntax groups *group-name* {{{2
  Comment       = { fg = palette.syntax.comment },

  Constant      = palette.syntax.literal,
  String        = palette.syntax.string,
  Character     = palette.syntax.character,
  Number        = palette.syntax.number,
  Boolean       = palette.syntax.boolean,
  Float         = palette.syntax.float,

  Identifier    = { fg = palette.syntax.identifier },
  Function      = { fg = palette.syntax["function"] },

  Statement     = { fg = palette.syntax.statement, bold = true },
  Operator      = { fg = palette.syntax.statement },

  PreProc       = { fg = palette.syntax.metaprogramming, bold = true },

  Type          = { fg = palette.syntax.type },
  StorageClass  = { fg = palette.syntax.storage_class },
  Structure     = { fg = palette.syntax.structure },
  Typedef       = { fg = palette.syntax.typedef },

  Special       = { fg = palette.syntax.special },
  SpecialChar   = { fg = palette.syntax.special, bg = palette.syntax.string.bg },
  Delimiter     = { link = "Special" },

  Underlined    = { fg = palette.syntax.underlined, underline = true, sp = palette.syntax.underlined },

  Error         = { fg = palette.neutral.max, bg = palette.diagnostics.error },

  Todo          = { bold = true },

  Added         = { fg = palette.diff.add.strong },
  Changed       = { fg = palette.diff.change.strong },
  Removed       = { fg = palette.diff.delete.strong },

  -- command line expressions *expr-highlight* {{{2
  -- TODO

  -- treesitter groups *treesitter-highlight-groups* {{{2
  ["@variable"]                    = { fg = palette.syntax.variable, italic = true },
  ["@variable.builtin"]            = { fg = palette.syntax.special, italic = true },
  ["@variable.parameter"]          = { fg = palette.syntax.parameter, italic = true },
  ["@variable.member"]             = { fg = palette.syntax.member, italic = true },

  ["@constant"]                    = { fg = palette.syntax.variable, italic = false, nocombine = true },
  ["@constant.builtin"]            = { link = "Constant" },

  ["@module"]                      = { fg = palette.syntax.module },

  ["@string.documenation"]         = { fg = palette.syntax.doc_comment, bg = palette.syntax.string.bg },
  ["@string.regexp"]               = { link = "SpecialChar" },
  ["@string.escape"]               = { link = "SpecialChar" },
  ["@string.special"]              = { link = "SpecialChar" },
  ["@string.special.symbol"]       = { link = "SpecialChar" },
  ["@string.special.path"]         = { link = "SpecialChar" },

  ["@character"]                   = { link = "Character" },
  ["@character.special"]           = { fg = palette.syntax.special, bg = palette.syntax.character.bg },

  ["@boolean"]                     = { link = "Boolean" },
  ["@number"]                      = { link = "Number" },
  ["@number.float"]                = { link = "Float" },

  ["@type"]                        = { link = "Structure" },
  ["@type.builtin"]                = { link = "Type" },
  ["@type.definition"]             = { link = "Typedef" },
  ["@type.qualifier"]              = { link = "Statement" },

  ["@attribute"]                   = { fg = palette.syntax.metaprogramming },
  ["@property"]                    = { fg = palette.syntax.property, italic = true },

  ["@constructor"]                 = { fg = palette.syntax["function"] },

  ["@keyword.coroutine"]           = { fg = palette.syntax["coroutine"], bold = true },
  ["@keyword.function"]            = { fg = palette.syntax["function"], bold = true },
  ["@keyword.operator"]            = { link = "Operator" },
  ["@keyword.import"]              = { fg = palette.syntax.module, bold = true },
  ["@keyword.storage"]             = { link = "StorageClass" },
  ["@keyword.repeat"]              = { link = "Repeat" },
  ["@keyword.exception"]           = { link = "Exception" },

  ["@keyword.conditional"]         = { link = "Conditional" },
  ["@keyword.conditional.ternary"] = { link = "Operator" },

  ["@keyword.directive"]           = { link = "PreProc" },
  ["@keyword.directive.define"]    = { link = "Define" },

  ["@comment.documentation"]       = { fg = palette.syntax.doc_comment },

  ["@tag"]                         = { fg = palette.syntax.statement, bold = true },
  ["@tag.attribute"]               = { link = "@property" },
  ["@tag.delimiter"]               = { link = "Delimiter" },

  -- LSP semantic highlight *lsp-semantic-highlight* {{{2
  ["@lsp.type.comment"]    = { fg = "NONE" },
  ["@lsp.type.decorator"]  = { link = "@attribute" },
  ["@lsp.type.enum"]       = { fg = palette.syntax.number.fg }, -- TODO
  ["@lsp.type.enumMember"] = { fg = palette.syntax.number.fg }, -- TODO
  ["@lsp.type.interface"]  = { link = "@attribute" },
  ["@lsp.type.namespace"]  = { link = "@module" },
  ["@lsp.type.parameter"]  = { link = "@variable.parameter" },
  ["@lsp.type.property"]   = { link = "@property" },
  ["@lsp.type.variable"]   = { link = "@variable" },

  -- LSP semantic highlight lang overrides {{{3
  ["@lsp.type.string.terraform-vars"] = { link = "String" },

  -- Plugins {{{2
  -- gitsigns | https://github.com/lewis6991/gitsigns.nvim {{{3
  GitSignsAdd    = { fg = palette.diff.add.strong, bg = framing.neutral.b.bg },
  GitSignsChange = { fg = palette.diff.change.strong, bg = framing.neutral.b.bg },
  GitSignsDelete = { fg = palette.diff.delete.strong, bg = framing.neutral.b.bg },

  -- lualine.nvim | https://github.com/nvim-lualine/lualine.nvim {{{3
  LualineA               = framing.current.normal,
  LualineB               = framing.neutral.b,
  LualineC               = framing.neutral.c,
  LualineInactiveA       = framing.neutral.a,
  LualineInsert          = { fg = framing.current.normal.fg, bg = palette.interact.modes.insert, bold = true },
  LualineReplace         = { fg = framing.current.normal.fg, bg = palette.interact.modes.replace, bold = true },
  LualineVisual          = { fg = framing.current.normal.fg, bg = palette.interact.modes.visual, bold = true },
  LualineModified        = { fg = framing.current.normal.fg, bg = palette.status.modified },
  LualineLazyPackages    = { fg = map_to_dark(palette.syntax.module), bg = framing.neutral.c.bg },
  LualineDiagnosticError = { fg = map_to_dark(palette.diagnostics.error), bg = framing.neutral.c.bg },
  LualineDiagnosticWarn  = { fg = map_to_dark(palette.diagnostics.warn), bg = framing.neutral.c.bg },
  LualineDiagnosticInfo  = { fg = map_to_dark(palette.diagnostics.info), bg = framing.neutral.c.bg },
  LualineDiagnosticHint  = { fg = map_to_dark(palette.diagnostics.hint), bg = framing.neutral.c.bg },

  -- nvim-navic | https://github.com/SmiteshP/nvim-navic {{{3
  NavicIconsArray         = { fg = map_to_dark(palette.syntax.structure), bg = framing.neutral.c.bg },
  NavicIconsBoolean       = { fg = map_to_dark(palette.syntax.boolean.fg), bg = framing.neutral.c.bg },
  NavicIconsClass         = { fg = map_to_dark(palette.syntax.structure), bg = framing.neutral.c.bg },
  NavicIconsConstant      = { fg = map_to_dark(palette.syntax.variable), bg = framing.neutral.c.bg },
  NavicIconsConstructor   = { fg = map_to_dark(palette.syntax["function"]), bg = framing.neutral.c.bg },
  NavicIconsEnum          = { fg = map_to_dark(palette.syntax.enum), bg = framing.neutral.c.bg },
  NavicIconsEnumMember    = { fg = map_to_dark(palette.syntax.enum_member), bg = framing.neutral.c.bg },
  NavicIconsEvent         = { fg = map_to_dark(palette.syntax.event), bg = framing.neutral.c.bg },
  NavicIconsField         = { fg = map_to_dark(palette.syntax.member), bg = framing.neutral.c.bg },
  NavicIconsFile          = { link = "StatusLineNC" },
  NavicIconsFunction      = { fg = map_to_dark(palette.syntax["function"]), bg = framing.neutral.c.bg },
  NavicIconsInterface     = { fg = map_to_dark(palette.syntax.metaprogramming), bg = framing.neutral.c.bg },
  NavicIconsKey           = { fg = map_to_dark(palette.syntax.property), bg = framing.neutral.c.bg },
  NavicIconsMethod        = { fg = map_to_dark(palette.syntax["function"]), bg = framing.neutral.c.bg },
  NavicIconsModule        = { fg = map_to_dark(palette.syntax.module), bg = framing.neutral.c.bg },
  NavicIconsNamespace     = { fg = map_to_dark(palette.syntax.module), bg = framing.neutral.c.bg },
  NavicIconsNull          = { fg = map_to_dark(palette.syntax.literal.fg), bg = framing.neutral.c.bg },
  NavicIconsNumber        = { fg = map_to_dark(palette.syntax.number.fg), bg = framing.neutral.c.bg },
  NavicIconsObject        = { fg = map_to_dark(palette.syntax.structure), bg = framing.neutral.c.bg },
  NavicIconsOperator      = { fg = map_to_dark(palette.syntax.statement), bg = framing.neutral.c.bg },
  NavicIconsPackage       = { fg = map_to_dark(palette.syntax.module), bg = framing.neutral.c.bg },
  NavicIconsProperty      = { fg = map_to_dark(palette.syntax.property), bg = framing.neutral.c.bg },
  NavicIconsString        = { fg = map_to_dark(palette.syntax.string.fg), bg = framing.neutral.c.bg },
  NavicIconsStruct        = { fg = map_to_dark(palette.syntax.structure), bg = framing.neutral.c.bg },
  -- NavicIconsTypeParameter = { fg = map_to_dark(palette.syntax.structure), bg = framing.neutral.c.bg },
  NavicIconsVariable      = { fg = map_to_dark(palette.syntax.variable), bg = framing.neutral.c.bg, italic = true },
  NavicSeparator          = { link = "StatusLineNC" },
  NavicText               = { link = "StatusLineNC" },

  -- noice.nvim | https://github.com/folke/noice.nvim {{{3
  NoiceCmdlineIcon              = { link = "DiagnosticInfo" },
  NoiceCmdlineIconSearch        = { link = "DiagnosticWarn" },
  NoiceCmdlinePopup             = { link = "NormalFloat" },
  NoiceCmdlinePopupBorder       = { link = "FloatBorder" },
  NoiceCmdlinePopupBorderSearch = { link = "FloatBorder" },
  NoiceCmdlinePopupTitle        = { link = "Title" },

  -- nvim-notify | https://github.com/rcarriga/nvim-notify {{{3
  NotifyDEBUGBorder = { fg = palette.diagnostics.debug },
  NotifyDEBUGIcon   = { fg = palette.diagnostics.debug },
  NotifyDEBUGTitle  = { fg = palette.diagnostics.debug },
  NotifyERRORBorder = { link = "DiagnosticError" },
  NotifyERRORIcon   = { link = "DiagnosticError" },
  NotifyERRORTitle  = { link = "DiagnosticError" },
  NotifyINFOBorder  = { link = "DiagnosticInfo" },
  NotifyINFOIcon    = { link = "DiagnosticInfo" },
  NotifyINFOTitle   = { link = "DiagnosticInfo" },
  NotifyTRACEBorder = { fg = palette.diagnostics.trace },
  NotifyTRACEIcon   = { fg = palette.diagnostics.trace },
  NotifyTRACETitle  = { fg = palette.diagnostics.trace },
  NotifyWARNBorder  = { link = "DiagnosticWarn" },
  NotifyWARNIcon    = { link = "DiagnosticWarn" },
  NotifyWARNTitle   = { link = "DiagnosticWarn" },

  -- vim-illuminate | https://github.com/RRethy/vim-illuminate {{{3
  IlluminatedWordText  = { link = "LspReferenceText" },
  IlluminatedWordRead  = { link = "LspReferenceRead" },
  IlluminatedWordWrite = { link = "LspReferenceWrite" },
  -- }}}2
}
--stylua: ignore end

--- Map a highlight group spec to a dark background version.
--- @param highlight vim.api.keyset.highlight
--- @return vim.api.keyset.highlight
local function map_hl_to_dark(highlight)
  return vim.tbl_extend("force", highlight, {
    fg = map_to_dark(highlight.fg),
    bg = map_to_dark(highlight.bg),
  })
end

--stylua: ignore start

--- @type table<string, vim.api.keyset.highlight>
local highlights_dark_overrides = {
}
--stylua: ignore end

--- @type table<string, vim.api.keyset.highlight>
local highlights_dark = vim.tbl_extend(
  "force",
  vim.tbl_map(map_hl_to_dark, highlights_light),
  highlights_dark_overrides
)

--- @param highlights table<string, vim.api.keyset.highlight>
local function add_cterm_values(highlights)
  local function convert_to_8bit(color)
    if color == nil or color == "NONE" then
      return color
    end

    return require("mini.colors").convert(color, "8-bit")
  end

  for _, value in pairs(highlights) do
    value.ctermfg = convert_to_8bit(value.fg)
    value.ctermbg = convert_to_8bit(value.bg)
  end
end

add_cterm_values(highlights_light)
add_cterm_values(highlights_dark)

-- Contrast ratios {{{1

-- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef
---@param fg string
---@param bg string
---@return number
local function get_contrast_ratio(fg, bg)
  -- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
  local function get_luminance(hex)
    local rgb = colors.convert(hex, "rgb") --[[@as table]]

    -- Convert decimal color to [0; 1]
    local r, g, b = rgb.r / 255, rgb.g / 255, rgb.b / 255

    -- Correct channels
    local function correct_channel(x)
      return x <= 0.04045 and (x / 12.92) or math.pow((x + 0.055) / 1.055, 2.4)
    end
    local R, G, B = correct_channel(r), correct_channel(g), correct_channel(b)

    return 0.2126 * R + 0.7152 * G + 0.0722 * B
  end

  local lum_fg, lum_bg = get_luminance(fg), get_luminance(bg)
  local res = (math.max(lum_bg, lum_fg) + 0.05)
    / (math.min(lum_bg, lum_fg) + 0.05)
  return math.floor(10 * res + 0.5) / 10
end

--- @param highlight vim.api.keyset.highlight
--- @param normal vim.api.keyset.highlight
--- @return number
local function get_highlight_contrast_ratio(highlight, normal)
  local function fallback_color(color, fallback)
    if color == nil or color == "NONE" then
      return fallback
    end

    return color
  end

  return get_contrast_ratio(
    fallback_color(highlight.fg, normal.fg),
    fallback_color(highlight.bg, normal.bg)
  )
end

-- Preview buffer {{{1

local function insert_highlight_preview_header(lines)
  table.insert(
    lines,
    string.format(
      "%4s %-30s %-8s %7s %7s %7s %7s %7s %5s %s",
      "Demo",
      "Name",
      "Contrast",
      "fg",
      "bg",
      "special",
      "ctermfg",
      "ctermbg",
      "blend",
      "attrs"
    )
  )
end

--- @param hls table<string, vim.api.keyset.highlight>
local function insert_highlight_preview_lines(lines, hls)
  local keys = vim.tbl_keys(hls)
  table.sort(keys)

  local bool_keys = {
    "bold",
    "standout",
    "strikethrough",
    "underline",
    "undercurl",
    "underdouble",
    "underdotted",
    "underdashed",
    "italic",
    "reverse",
    "altfont",
    "nocombine",
    "default",
    "fallback",
    "fg_indexed",
    "bg_indexed",
    "force",
  }

  for _, key in ipairs(keys) do
    local hl = hls[key]

    if hl.link then
      table.insert(lines, string.format("XXX  %-30s -> %s", key, hl.link))
    else
      table.insert(lines, (string
        .format(
          "XXX  %-30s %8.1f %7s %7s %7s %7s %7s %5d %s",
          key,
          get_highlight_contrast_ratio(hl, hls.Normal),
          hl.fg or "",
          hl.bg or "",
          hl.special or "",
          hl.ctermfg or "",
          hl.ctermbg or "",
          hl.blend or 0,
          table.concat(
            vim.tbl_filter(
              function(k)
                return k
              end,
              vim.tbl_map(function(k)
                return hl[k] and k or nil
              end, bool_keys)
            ),
            ","
          )
        )
        :gsub("%s+$", "")))
    end
  end
end

--- @param clrs string[]
--- @param bg string
local function insert_terminal_colors_preview_lines(lines, clrs, bg)
  for index, value in ipairs(clrs) do
    table.insert(
      lines,
      string.format(
        "XXX %2d %4.1f %7s",
        index - 1,
        get_contrast_ratio(value, bg),
        value
      )
    )
  end
end

--- @param name string
--- @param spec vim.api.keyset.highlight
--- @param ext_ns number
--- @param line_index number
local function color_preview(name, spec, ext_ns, line_index)
  vim.api.nvim_set_hl(0, name, spec)
  vim.api.nvim_buf_add_highlight(0, ext_ns, name, line_index, 0, 3)
end

--- @param normal vim.api.keyset.highlight
--- @param diagnostics vim.Diagnostic[]
local function color_highlight_preview_lines(
  ext_ns,
  start_after_line,
  hls,
  diagnostics,
  normal,
  suffix
)
  local keys = vim.tbl_keys(hls)
  table.sort(keys)

  for index, key in ipairs(keys) do
    local name = key .. "_preview_" .. suffix
    local hl = hls[key]
    local line_index = start_after_line + index

    --- @type vim.api.keyset.highlight | nil
    local spec
    if hl.link then
      local link_target = hls[hl.link]
      if link_target then
        spec = vim.tbl_extend("keep", link_target, normal)
      else
        spec = nil
      end
    else
      spec = vim.tbl_extend("keep", hl, normal)
    end
    if spec then
      color_preview(name, spec, ext_ns, line_index)

      local contrast = get_highlight_contrast_ratio(spec, normal)
      if contrast < 7 then
        table.insert(diagnostics, {
          lnum = line_index,
          col = 41,
          end_col = 44,
          severity = vim.diagnostic.severity.W,
          message = "Contrast is below 7.",
          source = "color-tool",
          code = "below-7",
        })
      end
    end
  end
end

--- @param normal vim.api.keyset.highlight
local function color_terminal_preview_lines(
  ext_ns,
  start_after_line,
  clrs,
  normal,
  suffix
)
  for index, value in ipairs(clrs) do
    local name = "terminal_color_" .. index - 1 .. "_" .. suffix

    local spec = { fg = value, bg = normal.bg }

    color_preview(name, spec, ext_ns, index + start_after_line)
  end
end

local function create_preview_buffer()
  local ext_ns = vim.api.nvim_create_namespace "highlight-previews-extmarks"
  local diag_ns = vim.api.nvim_create_namespace "highlight-previews-diagnostics"

  --- @type string[]
  local lines = {}

  vim.list_extend(lines, { "--- Highlights ---" })
  insert_highlight_preview_header(lines)
  vim.list_extend(lines, { "Light:" })
  insert_highlight_preview_lines(lines, highlights_light)
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "Dark:" })
  insert_highlight_preview_lines(lines, highlights_dark)
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "--- Terminal colors ---" })
  vim.list_extend(lines, { "Light:" })
  insert_terminal_colors_preview_lines(
    lines,
    palette.terminal_colors_light,
    highlights_light.Normal.bg
  )
  vim.list_extend(lines, { "" })
  vim.list_extend(lines, { "Dark:" })
  insert_terminal_colors_preview_lines(
    lines,
    palette.terminal_colors_dark,
    highlights_dark.Normal.bg
  )

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  --- @type vim.Diagnostic[]
  local diagnostics = {}

  local start_after_line = 2
  color_highlight_preview_lines(
    ext_ns,
    start_after_line,
    highlights_light,
    diagnostics,
    highlights_light.Normal,
    "light"
  )

  start_after_line = start_after_line + vim.tbl_count(highlights_light) + 2
  color_highlight_preview_lines(
    ext_ns,
    start_after_line,
    highlights_dark,
    diagnostics,
    highlights_dark.Normal,
    "dark"
  )

  start_after_line = start_after_line + vim.tbl_count(highlights_dark) + 3
  color_terminal_preview_lines(
    ext_ns,
    start_after_line,
    palette.terminal_colors_light,
    highlights_light.Normal,
    "light"
  )

  start_after_line = start_after_line
    + vim.tbl_count(palette.terminal_colors_light)
    + 2
  color_terminal_preview_lines(
    ext_ns,
    start_after_line,
    palette.terminal_colors_dark,
    highlights_dark.Normal,
    "dark"
  )

  vim.diagnostic.set(diag_ns, 0, diagnostics)

  vim.opt_local.bufhidden = "hide"
  vim.opt_local.buftype = "nofile"
  vim.opt_local.swapfile = false
  vim.opt_local.wrap = false

  vim.keymap.set("n", "R", "<Cmd>source lua/color-tool.lua<CR>", {
    buffer = true,
    silent = true,
    desc = "Reload the preview buffer.",
  })
end

if SHOW_PREVIEW_BUFFER then
  create_preview_buffer()
end

-- Highlight groups {{{1

local function write_nvim_colors()
  local file =
    io.open(vim.fn.stdpath "config" .. "/colors/" .. THEME_NAME .. ".lua", "w")
  if not file then
    vim.notify("Could not open nvim color scheme file.", vim.log.levels.WARN)
    return
  end

  local function insert_highlight_lines(lines, highlights)
    local keys = vim.tbl_keys(highlights)
    table.sort(keys)

    for _, key in ipairs(keys) do
      table.insert(
        lines,
        string.format(
          '  vim.api.nvim_set_hl(0, "%s", %s)',
          key,
          vim.inspect(highlights[key], { indent = "", newline = "" })
        )
      )
    end
  end

  local function insert_terminal_colors(lines, clrs)
    for index, color in ipairs(clrs) do
      table.insert(
        lines,
        string.format('  vim.g.terminal_color_%d = "%s"', index - 1, color)
      )
    end
  end

  local lines = {
    "-- This is a theme generated by color-tool.lua.",
    "",
    'vim.cmd.highlight "clear"',
    'vim.g.colors_name = vim.fn.expand "<sfile>:t:r"',
    "",
    'if vim.o.background == "light" then',
  }
  insert_highlight_lines(lines, highlights_light)
  insert_terminal_colors(lines, palette.terminal_colors_light)
  table.insert(lines, "else")
  insert_highlight_lines(lines, highlights_dark)
  insert_terminal_colors(lines, palette.terminal_colors_dark)
  table.insert(lines, "end")

  file:write(table.concat(lines, "\n"))
  file:flush()
  file:close()
end

local function write_lualine_colors()
  local file = io.open(
    vim.fn.stdpath "config" .. "/lua/lualine/themes/" .. THEME_NAME .. ".lua",
    "w"
  )
  if not file then
    vim.notify("Could not open lualine theme file.", vim.log.levels.WARN)
    return
  end

  local lines = {
    "-- This is a theme generated by color-tool.lua",
    "",
    "-- This replaces the default statusline highlight with the WinSeparator",
    "-- highlight. This is meant to be used to remove the differing, one character",
    "-- highlight on the right side of the statusline for windows on the bottom when",
    "-- lualine is in use.",
    'vim.api.nvim_set_hl(0, "StatusLine", { link = "WinSeparator" })',
    "",
    "return " .. vim.inspect {
      normal = {
        a = "LualineA",
        b = "LualineB",
        c = "LualineC",
      },
      insert = {
        a = "LualineInsert",
      },
      replace = {
        a = "LualineReplace",
      },
      visual = {
        a = "LualineVisual",
      },
      command = {},
      inactive = {
        a = "LualineInactiveA",
      },
    },
  }

  file:write(table.concat(lines, "\n"))

  file:flush()
  file:close()
end

-- Comment this to not enable color scheme
if WRITE_COLORSCHEME then
  write_nvim_colors()
  write_lualine_colors()
end
