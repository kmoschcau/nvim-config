-- vim: foldmethod=marker
-- -----------------------------------------------------------------------------
-- File:          material.vim
-- Description:   A configurable material based theme
-- Author:        Kai Moschcau <mail@kmoschcau.de>
-- -----------------------------------------------------------------------------

local utils = require "colors.material.utils"
local color_table = utils.color_table
local highlight = utils.highlight
local constants = require "colors.material.constants"
local hues = constants.hues
local colors = constants.colors()

-- General setup {{{1

-- Reset all highlight groups to the default.
vim.cmd.highlight "clear"

-- Set the name of the colortheme.
vim.g.colors_name = vim.fn.expand "<sfile>:t:r"

-- Highlight definitions {{{2
-- Basics {{{3

-- This is somewhat of a hack and not like I intended it. But just linking the
-- Normal group to anything instead of defining it on its own will cause the
-- current window to have a transparent background for some reason.
highlight("Material_VimNormal", { link = "Normal" })
highlight("Normal", {
  fg = colors.neutral.strong,
  bg = colors.neutral.lightest,
})
highlight("Material_VimNormalLight", {
  fg = color_table(hues.neutral, 4),
  fg_dark = color_table(hues.neutral, 2),
})
highlight("Material_VimSpecialKey", {
  fg = colors.neutral.strong,
  bg = color_table(hues.neutral, 3),
  italic = true,
})
highlight("Material_VimConceal", { fg = colors.neutral.strong })

-- Popup menu and floating windows {{{3

highlight("Material_VimPopup", {
  fg = colors.neutral.strong,
  bg = color_table(hues.neutral, 2),
})
highlight("Material_VimPopupSelected", { bg = colors.interact.light })
highlight("Material_VimPopupScrollbar", { bg = colors.neutral.midpoint })
highlight("Material_VimPopupThumb", { bg = color_table(hues.neutral, 10) })

-- Framing {{{3

highlight("Material_VimLighterFraming", { bg = color_table(hues.neutral, 2) })
highlight("Material_VimLightFramingSubtleFg", {
  fg = color_table(hues.neutral, 7),
  bg = colors.neutral.midpoint,
})
highlight("Material_VimLightFramingStrongFg", {
  fg = colors.neutral.lightest,
  bg = colors.neutral.midpoint,
})
highlight("Material_VimStrongFramingWithoutFg", { bg = colors.neutral.strong })
highlight("Material_VimStrongFramingWithFg", {
  fg = color_table(hues.neutral, 1, { accent = true }),
  bg = colors.neutral.strong,
})
highlight("Material_VimStatusLine", {
  fg = colors.neutral.lightest,
  bg = color_table(hues.primary, 4, { accent = true }),
  bold = true,
})
highlight("Material_VimStatusLineNC", {
  fg = colors.neutral.lightest,
  bg = colors.neutral.strong,
})

-- Signs {{{3

highlight("Material_SignBreakpoint", {
  fg = color_table("red", 6),
  bg = colors.neutral.midpoint,
})
highlight("Material_SignBreakpointConditional", {
  fg = color_table("red", 6),
  bg = colors.neutral.midpoint,
})
highlight("Material_SignLogpoint", {
  fg = color_table("yellow", 6),
  bg = colors.neutral.midpoint,
})
highlight("Material_SignCurrentFrame", {
  fg = color_table("green", 6),
  bg = colors.neutral.midpoint,
})
highlight("Material_SignBreakpointRejected", {
  fg = colors.neutral.midpoint_strong,
  bg = colors.neutral.midpoint,
})

-- Cursor related {{{3

highlight("Material_VimVisual", { bg = colors.interact.light })
highlight("Material_VimWildMenu", {
  fg = colors.neutral.lightest,
  bg = color_table(hues.primary, 3),
  bold = true,
})
highlight("Material_VimCursorLines", { bg = colors.interact.light })
highlight("Material_VimCursorLinesNum", {
  fg = colors.neutral.midpoint_strong,
  bg = colors.interact.light,
  bold = true,
})
highlight("Material_VimCursor", { bg = color_table(hues.primary, 6) })
highlight("Material_VimCursorInsert", { bg = color_table(hues.insert, 7) })
highlight("Material_VimCursorReplace", { bg = color_table(hues.replace, 7) })
highlight("Material_VimCursorUnfocused", { bg = color_table(hues.primary, 3) })

-- Diff related {{{3

highlight("Material_VimDiffAdd", { fg = colors.diff.added.midpoint_strong })
highlight(
  "Material_VimDiffDelete",
  { fg = colors.diff.deleted.midpoint_strong }
)
highlight("Material_VimDiffLineAdd", {
  bg = colors.diff.added.lightest,
  bg_dark = color_table(hues.diff.added, 10, { invert_dark = false }),
})
highlight("Material_VimDiffLineChange", {
  bg = colors.diff.changed.lightest,
  bg_dark = color_table(hues.diff.changed, 10, { invert_dark = false }),
})
highlight("Material_VimDiffLineChangeDelete", {
  bg = colors.diff.changed.lighter,
  bg_dark = color_table(hues.diff.changed, 9, { invert_dark = false }),
})
highlight("Material_VimDiffLineDelete", {
  bg = colors.diff.deleted.lightest,
  bg_dark = color_table(hues.diff.deleted, 10, { invert_dark = false }),
})
highlight("Material_VimDiffLineText", {
  bg = colors.diff.text.lightest,
  bg_dark = color_table(hues.diff.text, 10, { invert_dark = false }),
  bold = true,
})
highlight("Material_VimDiffSignAdd", {
  fg = colors.neutral.lightest,
  bg = colors.diff.added.midpoint_strong,
})
highlight("Material_VimDiffSignChange", {
  fg = colors.neutral.lightest,
  bg = colors.diff.changed.midpoint_strong,
})
highlight("Material_VimDiffSignChangeDelete", {
  fg = colors.neutral.lightest,
  bg = colors.diff.changed.midpoint_stronger,
})
highlight("Material_VimDiffSignDelete", {
  fg = colors.neutral.lightest,
  bg = color_table(hues.diff.deleted, 6),
})

-- Messages {{{3

highlight("Material_VimTitle", { fg = color_table("pink", 5), bold = true })
highlight("Material_VimModeMsg", { fg = colors.neutral.strong, bold = true })
highlight("Material_VimMoreMsg", { fg = color_table("green", 8), bold = true })

highlight("Material_VimError", { fg = colors.levels.error.strong })
highlight("Material_VimErrorBorder", { fg = colors.levels.error.light })
highlight("Material_VimErrorInverted", {
  fg = colors.neutral.lightest,
  bg = colors.levels.error.strong,
})
highlight("Material_VimErrorUnderline", {
  sp = colors.levels.error.strong,
  underline = true,
})

highlight("Material_VimStyleErrorInverted", {
  fg = colors.neutral.lightest,
  bg = colors.levels.error.light,
})
highlight("Material_VimStyleErrorUnderline", {
  sp = colors.levels.error.light,
  undercurl = true,
})

highlight("Material_VimWarning", { fg = colors.levels.warning.strong })
highlight("Material_VimWarningBorder", { fg = colors.levels.warning.light })
highlight("Material_VimWarningInverted", {
  fg = colors.neutral.lightest,
  bg = colors.levels.warning.strong,
})
highlight("Material_VimWarningUnderline", {
  sp = colors.levels.warning.strong,
  underline = true,
})

highlight("Material_VimStyleWarningInverted", {
  fg = colors.neutral.lightest,
  bg = colors.levels.warning.light,
})
highlight("Material_VimStyleWarningUnderline", {
  sp = colors.levels.warning.light,
  undercurl = true,
})

highlight("Material_VimSuccessInverted", {
  fg = color_table(hues.neutral, 8, { invert_dark = false }),
  bg = colors.levels.success.strong,
})

highlight("Material_VimInfo", { fg = colors.levels.info.strong })
highlight("Material_VimInfoBorder", { fg = colors.levels.info.light })
highlight("Material_VimInfoInverted", {
  fg = colors.neutral.lightest,
  bg = colors.levels.info.strong,
})
highlight("Material_VimInfoUnderline", {
  sp = colors.levels.info.strong,
  underline = true,
})

highlight("Material_VimDebug", { fg = colors.levels.debug.strong })
highlight("Material_VimDebugInverted", {
  fg = colors.neutral.lightest,
  bg = colors.levels.debug.strong,
})
highlight("Material_VimDebugBorder", { fg = colors.levels.debug.light })

highlight("Material_VimTrace", { fg = colors.levels.trace.strong })
highlight("Material_VimTraceInverted", {
  fg = colors.neutral.lightest,
  bg = colors.levels.trace.strong,
})
highlight("Material_VimTraceBorder", { fg = colors.levels.trace.light })

highlight("Material_VimHintInverted", {
  fg = colors.neutral.lightest,
  bg = colors.levels.info.light,
})
highlight("Material_VimHintUnderline", {
  sp = colors.levels.info.light,
  underline = true,
})

-- Spelling {{{3

highlight("Material_VimSpellBad", {
  sp = colors.levels.error.strong,
  undercurl = true,
})
highlight("Material_VimSpellCap", {
  sp = color_table("indigo", 6),
  undercurl = true,
})
highlight("Material_VimSpellLocal", {
  sp = color_table("teal", 6),
  undercurl = true,
})
highlight("Material_VimSpellRare", {
  sp = color_table("pink", 4),
  undercurl = true,
})

-- Misc {{{3

highlight("Material_VimDirectory", { fg = color_table("blue", 5), bold = true })
highlight("Material_VimFolded", {
  fg = colors.neutral.midpoint_strong,
  bg = color_table(hues.neutral, 3),
})
highlight("Material_VimSearch", {
  bg = color_table("yellow", 6),
  bg_dark = color_table("lime", 9, { invert_dark = false }),
})
highlight("Material_VimCurSearch", {
  bg = color_table("yellow", 2),
  bg_dark = color_table("lime", 10, { invert_dark = false }),
})
highlight("Material_VimIncSearch", {
  bg = color_table("orange", 6),
  bg_dark = color_table("orange", 10, { invert_dark = false }),
  bold = true,
})
highlight("Material_VimMatchParen", { bg = color_table("teal", 2) })

-- LSP {{{3

highlight("Material_LspReferenceText", {
  bg = color_table("yellow", 3),
  bg_dark = color_table("lime", 10, { invert_dark = false }),
})
highlight("Material_LspReferenceRead", { bg = color_table("green", 2) })
highlight("Material_LspReferenceWrite", { bg = color_table("blue", 2) })
highlight("Material_LspInlayHint", {
  fg = colors.neutral.midpoint_strong,
  bg = color_table(hues.neutral, 3),
})

-- Testing {{{3

highlight("Material_DebugTest", {
  fg = color_table("blue", 4),
  bg = color_table("green", 9),
  sp = color_table("red", 3),
  bold = true,
  italic = true,
  undercurl = true,
})

-- Syntax {{{3
-- Built-in {{{4

-- Comment and linked groups
highlight("Material_SynComment", { fg = colors.neutral.midpoint_strong })

-- Constant and linked groups
local h_syn_constant = {
  fg = color_table("blue_grey", 7),
  bg = color_table("blue_grey", 1),
}
highlight("Material_SynConstant", h_syn_constant)
local h_syn_string = {
  fg = color_table("green", 7),
  bg = color_table("green", 1),
}
highlight("Material_SynString", h_syn_string)
highlight("Material_SynCharacter", {
  fg = color_table("light_green", 7),
  bg = color_table("light_green", 1),
})
local h_syn_number = {
  fg = color_table("blue", 7),
  bg = colors.syntax.number.light,
}
highlight("Material_SynNumber", h_syn_number)
local h_syn_boolean = {
  fg = color_table("orange", 7),
  bg = color_table("orange", 1),
}
highlight("Material_SynBoolean", h_syn_boolean)
highlight("Material_SynFloat", {
  fg = color_table("light_blue", 7),
  bg = color_table("light_blue", 1),
})

-- Statement and linked groups
local h_syn_statement = {
  fg = color_table("orange", 7),
  bold = true,
}
highlight("Material_SynStatement", h_syn_statement)
local h_syn_operator = { fg = color_table("orange", 7) }
highlight("Material_SynOperator", h_syn_operator)

-- PreProc and linked groups
highlight("Material_SynPreProc", { fg = color_table("teal", 5), bold = true })

-- Type and linked groups
highlight("Material_SynStorageClass", {
  fg = color_table("yellow", 8),
  bold = true,
})

-- Special and linked groups
highlight("Material_SynSpecial", { fg = color_table("red", 7) })
highlight("Material_SynSpecialChar", {
  fg = color_table("red", 7),
  bg = color_table("green", 1),
})

-- Underlined and linked groups
highlight("Material_SynUnderlined", {
  fg = color_table("blue", 7),
  underline = true,
})

-- Custom {{{4
-- General {{{5

highlight("Material_SynBold", { bold = true })
highlight("Material_SynItalic", { italic = true })

-- Non-Value symbols
local h_syn_doc_comment = { fg = color_table("blue_grey", 6) }
highlight("Material_SynDocComment", h_syn_doc_comment)
highlight("Material_SynExtensionMethod", { fg = color_table("teal", 4) })
highlight("Material_SynOperatorOverloaded", {
  fg = color_table("orange", 7),
  bg = color_table("orange", 2),
})
highlight("Material_SynStringVerbatim", {
  fg = color_table("green", 7),
  bg = color_table("green", 2),
})

-- Literals

-- Member variables
local h_syn_field_name = {
  fg = color_table("blue", 6),
  italic = true,
}
highlight("Material_SynFieldName", h_syn_field_name)
highlight("Material_SynFieldNameNonItalic", {
  fg = color_table("blue", 6),
  italic = false,
  nocombine = true,
})

-- Other value holders
local h_syn_constant_name = {
  fg = color_table("orange", 5),
  italic = false,
  nocombine = true,
}
highlight("Material_SynConstantName", h_syn_constant_name)
local h_syn_variable_name = {
  fg = color_table("orange", 5),
  italic = true,
}
highlight("Material_SynVariableName", h_syn_variable_name)
highlight("Material_SynParameterName", {
  fg = color_table("orange", 9),
  italic = true,
})

-- Functions and methods
highlight("Material_SynFunctionKeyword", {
  fg = colors.syntax["function"],
  bold = true,
})
local h_syn_function_name = {
  fg = colors.syntax["function"],
  italic = false,
  nocombine = true,
}
highlight("Material_SynFunctionName", h_syn_function_name)
highlight("Material_SynMemberName", { fg = colors.syntax["function"] })
highlight("Material_SynPropertyKeyword", {
  fg = color_table("cyan", 6),
  bold = true,
})
local h_syn_property_name = {
  fg = color_table("cyan", 6),
  italic = true,
}
highlight("Material_SynPropertyName", h_syn_property_name)
highlight("Material_SynAnonymousFunctionName", {
  fg = colors.syntax["function"],
  bg = colors.syntax.meta.light,
})

-- Types (primitive types and similar)
highlight("Material_SynTypeKeyword", { fg = colors.syntax.type, bold = true })
highlight("Material_SynTypeName", { fg = colors.syntax.type })

-- Structures (smaller than classes, but not quite primitive types)
highlight("Material_SynStructureKeyword", {
  fg = colors.syntax.structure,
  bold = true,
})
local h_syn_structure_name = {
  fg = colors.syntax.structure,
  italic = false,
  nocombine = true,
}
highlight("Material_SynStructureName", h_syn_structure_name)

-- Enums (same as structures, but with enumerated variants)
highlight("Material_SynEnumKeyword", {
  fg = colors.syntax.enum.name,
  bold = true,
})
highlight("Material_SynEnumName", { fg = colors.syntax.enum.name })
highlight("Material_SynEnumMember", {
  fg = colors.syntax.enum.member,
  italic = false,
  nocombine = true,
})

-- Typedefs (Classes and equally large/extensible things)
highlight("Material_SynTypedefKeyword", {
  fg = colors.syntax.typedef,
  bold = true,
})
local h_syn_typedef_name = {
  fg = colors.syntax.typedef,
  italic = false,
  nocombine = true,
}
highlight("Material_SynTypedefName", h_syn_typedef_name)

-- Namespaces (or anything that groups together definitions)
highlight("Material_SynNamespaceKeyword", {
  fg = colors.syntax.namespace,
  bold = true,
})
local h_syn_namespace_name = {
  fg = colors.syntax.namespace,
  italic = false,
  nocombine = true,
}
highlight("Material_SynNamespaceName", h_syn_namespace_name)

-- Generics
highlight("Material_SynGenericSpecial", { fg = color_table("purple", 4) })
highlight("Material_SynGenericBackground", { bg = colors.syntax.meta.light })
local h_syn_generic_parameter_name = {
  fg = color_table("orange", 6),
  bg = colors.syntax.meta.light,
}
highlight("Material_SynGenericParameterName", h_syn_generic_parameter_name)
highlight("Material_SynDecorator", {
  fg = colors.syntax.meta.strong,
  italic = false,
  nocombine = true,
})

-- Interfaces (or anything that is just a declaration, but not implementation)
highlight("Material_SynInterfaceKeyword", {
  fg = colors.syntax.meta.strong,
  bold = true,
})
local h_syn_interface_name = {
  fg = colors.syntax.meta.strong,
  italic = false,
  nocombine = true,
}
highlight("Material_SynInterfaceName", h_syn_interface_name)

-- Modifiers {{{5

highlight("Material_SynModAbstract", { bg = color_table("purple", 1) })
highlight("Material_SynModAsync", { bg = colors.syntax.coroutine.light })
highlight("Material_SynModReadonly", { italic = false, nocombine = true })
highlight("Material_SynModStatic", { bold = true })
highlight("Material_SynModDeprecated", { strikethrough = true })

-- Linked highlight groups {{{1
-- Non-editor window highlights {{{2
-- Framing {{{3

highlight("MsgSeparator", { link = "Material_VimStrongFramingWithoutFg" })
highlight("TabLineFill", { link = "Material_VimStrongFramingWithoutFg" })
highlight("WinSeparator", { link = "Material_VimStrongFramingWithoutFg" })

highlight("FoldColumn", { link = "Material_VimLightFramingSubtleFg" })
highlight("SignColumn", { link = "Material_VimLightFramingSubtleFg" })
highlight("LineNr", { link = "Material_VimLightFramingSubtleFg" })

highlight("ColorColumn", { link = "Material_VimLighterFraming" })

highlight("CursorLineNr", { link = "Material_VimCursorLinesNum" })

highlight("TabLine", { link = "Material_VimLightFramingStrongFg" })
highlight("TabLineSel", { link = "Material_VimNormal" })
highlight("Title", { link = "Material_VimTitle" })

highlight("StatusLine", { link = "Material_VimStatusLine" })
highlight("StatusLineNC", { link = "Material_VimStatusLineNC" })
highlight("StatusLineTerm", { link = "Material_VimStatusLine" })
highlight("StatusLineTermNC", { link = "Material_VimStatusLineNC" })

highlight("WildMenu", { link = "Material_VimWildMenu" })

-- Popup menu and floating windows {{{3

highlight("Pmenu", { link = "Material_VimPopup" })
highlight("PmenuSel", { link = "Material_VimPopupSelected" })
highlight("PmenuSbar", { link = "Material_VimPopupScrollbar" })
highlight("PmenuThumb", { link = "Material_VimPopupThumb" })
highlight("NormalFloat", { link = "Material_VimPopup" })
highlight("FloatBorder", { link = "Material_VimPopup" })

-- Editor window highlights {{{2
-- Normal text {{{3

-- for the Normal group, see the definition of Material_VimNormal
highlight("NonText", { link = "Material_VimNormalLight" })
highlight("NormalNC", { link = "Material_VimNormal" })
highlight("MsgArea", { link = "Material_VimNormal" })

-- Cursor {{{3

highlight("CurSearch", { link = "Material_VimCurSearch" })
highlight("Cursor", { link = "Material_VimCursor" })
highlight("CursorColumn", { link = "Material_VimCursorLines" })
highlight("CursorIM", { link = "Material_DebugTest" })
highlight("CursorInsert", { link = "Material_VimCursorInsert" })
highlight("CursorLine", { link = "Material_VimCursorLines" })
highlight("CursorReplace", { link = "Material_VimCursorReplace" })
highlight("IncSearch", { link = "Material_VimIncSearch" })
highlight("MatchParen", { link = "Material_VimMatchParen" })
highlight("QuickFixLine", { link = "Material_VimVisual" })
highlight("Search", { link = "Material_VimSearch" })
highlight("Substitute", { link = "Material_VimSearch" })
highlight("TermCursor", { link = "Material_VimCursor" })
highlight("TermCursorNC", { link = "Material_VimCursorUnfocused" })
highlight("Visual", { link = "Material_VimVisual" })
highlight("VisualNOS", { link = "Material_VimDiffLineText" })

-- Special character visualization {{{3

highlight("Conceal", { link = "Material_VimConceal" })
highlight("EndOfBuffer", { link = "Material_VimNormalLight" })
highlight("SpecialKey", { link = "Material_VimSpecialKey" })
highlight("Whitespace", { link = "Material_VimNormalLight" })

-- Diff {{{3

highlight("DiffAdd", { link = "Material_VimDiffLineAdd" })
highlight("DiffChange", { link = "Material_VimDiffLineChange" })
highlight("DiffDelete", { link = "Material_VimDiffLineDelete" })
highlight("DiffText", { link = "Material_VimDiffLineText" })

-- Spelling {{{3

highlight("SpellBad", { link = "Material_VimSpellBad" })
highlight("SpellCap", { link = "Material_VimSpellCap" })
highlight("SpellLocal", { link = "Material_VimSpellLocal" })
highlight("SpellRare", { link = "Material_VimSpellRare" })

-- Diagnostics {{{3

highlight("DiagnosticError", { link = "Material_VimErrorInverted" })
highlight("DiagnosticWarn", { link = "Material_VimWarningInverted" })
highlight("DiagnosticInfo", { link = "Material_VimInfoInverted" })
highlight("DiagnosticHint", { link = "Material_VimHintInverted" })
highlight("DiagnosticOk", { link = "Material_VimSuccessInverted" })

highlight("DiagnosticUnderLineError", { link = "Material_VimErrorUnderline" })
highlight("DiagnosticUnderLineWarn", { link = "Material_VimWarningUnderline" })
highlight("DiagnosticUnderLineInfo", { link = "Material_VimInfoUnderline" })
highlight("DiagnosticUnderLineHint", { link = "Material_VimHintUnderline" })

-- Special items {{{2

highlight("Directory", { link = "Material_VimDirectory" })
highlight("Folded", { link = "Material_VimFolded" })

-- Messages {{{2

highlight("ErrorMsg", { link = "Material_VimErrorInverted" })
highlight("ModeMsg", { link = "Material_VimModeMsg" })
highlight("MoreMsg", { link = "Material_VimMoreMsg" })
highlight("Question", { link = "Material_VimMoreMsg" })
highlight("WarningMsg", { link = "Material_VimWarningInverted" })

-- Syntax groups {{{2

highlight("Comment", { link = "Material_SynComment" })

highlight("Constant", { link = "Material_SynConstant" })
highlight("String", { link = "Material_SynString" })
highlight("Character", { link = "Material_SynCharacter" })
highlight("Number", { link = "Material_SynNumber" })
highlight("Boolean", { link = "Material_SynBoolean" })
highlight("Float", { link = "Material_SynFloat" })

highlight("Identifier", { link = "Material_SynStructureName" })
highlight("Function", { link = "Material_SynFunctionName" })

highlight("Statement", { link = "Material_SynStatement" })
highlight("Operator", { link = "Material_SynOperator" })

highlight("PreProc", { link = "Material_SynPreProc" })

highlight("Type", { link = "Material_SynTypeKeyword" })
highlight("StorageClass", { link = "Material_SynStorageClass" })
highlight("Structure", { link = "Material_SynStructureKeyword" })
highlight("Typedef", { link = "Material_SynTypedefKeyword" })

highlight("Special", { link = "Material_SynSpecial" })
highlight("SpecialChar", { link = "Material_SynSpecialChar" })
highlight("Delimiter", { link = "Special" })

highlight("Underlined", { link = "Material_SynUnderlined" })

highlight("Error", { link = "Material_VimErrorInverted" })

highlight("Added", { link = "Material_VimDiffLineAdd" })
highlight("Changed", { link = "Material_VimDiffLineText" })
highlight("Removed", { link = "Material_VimDiffLineDelete" })

-- Treesitter {{{3

-- Built-in {{{4

highlight("@variable", { link = "Material_SynVariableName" })
highlight("@variable.parameter", { link = "Material_SynParameterName" })
highlight("@variable.member", { link = "Material_SynFieldName" })

highlight("@constant", { link = "Material_SynConstantName" })
highlight("@constant.builtin", { link = "Material_SynConstant" })

highlight("@module", { link = "Material_SynNamespaceName" })

highlight("@string.documentation", {
  fg = h_syn_doc_comment.fg,
  bg = h_syn_string.bg,
})

highlight("@type", { link = "Material_SynStructureName" })
highlight("@type.definition", { link = "Material_SynTypedefName" })
highlight("@type.qualifier", { link = "Material_SynStatement" })

highlight("@attribute", { link = "Material_SynDecorator" })
highlight("@property", { link = "Material_SynPropertyName" })

highlight("@constructor", { link = "Material_SynFunctionName" })

highlight("@keyword.coroutine", {
  fg = colors.syntax.coroutine.strong,
  fg_dark = colors.syntax.coroutine.light,
  bold = true,
})
highlight("@keyword.function", { link = "Material_SynFunctionKeyword" })
highlight("@keyword.operator", { link = "Material_SynOperator" })
highlight("@keyword.import", { link = "Material_SynNamespaceKeyword" })

highlight("@keyword.conditional.ternary", { link = "Material_SynOperator" })

highlight("@comment.documentation", { link = "Material_SynDocComment" })

highlight("@tag", { link = "Material_SynStatement" })
highlight("@tag.attribute", { link = "Material_SynPropertyName" })
highlight("@tag.delimiter", { link = "Material_SynSpecial" })

-- Custom Query highlights {{{4

highlight("@class", { link = "Material_SynTypedefName" })
highlight("@enum", { link = "Material_SynEnumName" })
highlight("@generic.special", { link = "Material_SynGenericSpecial" })
highlight("@keyword.class", { link = "Material_SynTypedefKeyword" })
highlight("@keyword.enum", { link = "Material_SynEnumKeyword" })
highlight("@keyword.interface", { link = "Material_SynInterfaceKeyword" })
highlight("@keyword.module", { link = "Material_SynNamespaceKeyword" })
highlight("@keyword.property", { link = "Material_SynPropertyKeyword" })
highlight("@interface", { link = "Material_SynInterfaceName" })

-- LSP {{{3

-- Semantic Types {{{4

highlight("@lsp.type.annotation", { link = "@lsp.type.decorator" })
highlight("@lsp.type.attribute", { link = "@lsp.type.decorator" })
highlight("@lsp.type.class", { link = "Material_SynTypedefName" })
highlight("@lsp.type.decorator", { link = "Material_SynDecorator" })
highlight("@lsp.type.enum", { link = "Material_SynEnumName" })
highlight("@lsp.type.enumMember", { link = "Material_SynEnumMember" })
highlight("@lsp.type.interface", { link = "Material_SynInterfaceName" })
highlight("@lsp.type.member", { link = "Material_SynMemberName" })
highlight("@lsp.type.typeParameter", {
  link = "Material_SynGenericParameterName",
})

-- Semantic Modifiers {{{4

highlight("@lsp.mod.abstract", { link = "Material_SynModAbstract" })
highlight("@lsp.mod.async", { link = "Material_SynModAsync" })
highlight("@lsp.mod.deprecated", { link = "Material_SynModDeprecated" })
highlight("@lsp.mod.readonly", { link = "Material_SynModReadonly" })
highlight("@lsp.mod.static", { link = "Material_SynModStatic" })

-- Semantic Type/Modifier Combinations {{{4

highlight("@lsp.typemod.annotation.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.attribute.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.class.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.decorator.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.enum.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.enumMember.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.function.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.interface.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.keyword.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.member.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.method.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.namespace.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.parameter.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.property.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.string.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.struct.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.type.static", { link = "Material_SynModStatic" })
highlight("@lsp.typemod.typeParameter.static", {
  link = "Material_SynModStatic",
})
highlight("@lsp.typemod.variable.static", { link = "Material_SynModStatic" })

-- References {{{4

highlight("LspReferenceText", { link = "Material_LspReferenceText" })
highlight("LspReferenceRead", { link = "Material_LspReferenceRead" })
highlight("LspReferenceWrite", { link = "Material_LspReferenceWrite" })
highlight("LspInlayHint", { link = "Material_LspInlayHint" })

-- Code Lens {{{4

highlight("LspCodeLens", { link = "Material_SynComment" })
highlight("LspCodeLensSeparator", { link = "Material_SynComment" })

-- Signature Help {{{4

highlight("LspSignatureActiveParameter", { link = "Material_VimSearch" })

-- custom variables {{{1
-- terminal color variables {{{2

vim.g.terminal_color_0 = color_table("grey", 9).gui
vim.g.terminal_color_1 = color_table("red", 6).gui
vim.g.terminal_color_2 = color_table("light_green", 6).gui
vim.g.terminal_color_3 = color_table("orange", 6).gui
vim.g.terminal_color_4 = color_table("blue", 6).gui
vim.g.terminal_color_5 = color_table("purple", 6).gui
vim.g.terminal_color_6 = color_table("teal", 6).gui
vim.g.terminal_color_7 = color_table("grey", 3).gui
vim.g.terminal_color_8 = color_table("grey", 10).gui
vim.g.terminal_color_9 = color_table("red", 8).gui
vim.g.terminal_color_10 = color_table("light_green", 8).gui
vim.g.terminal_color_11 = color_table("orange", 8).gui
vim.g.terminal_color_12 = color_table("blue", 8).gui
vim.g.terminal_color_13 = color_table("purple", 8).gui
vim.g.terminal_color_14 = color_table("teal", 8).gui
vim.g.terminal_color_15 = color_table("grey", 4).gui

-- custom highlight groups {{{1
-- File type highlight groups {{{2
-- cs (C#) {{{3

highlight("csBraces", { link = "Material_SynSpecial" })
highlight("csClass", { link = "Material_SynTypedefKeyword" })
highlight("csClassType", { link = "Material_SynTypedefName" })
highlight("csEndColon", { link = "Material_SynSpecial" })
highlight("csGeneric", { link = "Material_SynGenericBackground" })
highlight("csNewType", { link = "Material_SynTypedefName" })
highlight("csParens", { link = "Material_SynSpecial" })
highlight("csStorage", { link = "Material_SynNamespaceKeyword" })

-- LSP {{{4

highlight("@lsp.type.constant.cs", { link = "Material_SynFieldNameNonItalic" })
highlight("@lsp.type.comment.documentation.attribute.name", {
  fg = color_table("blue", 4),
  fg_dark = color_table("blue", 9, { invert_dark = false }),
})
highlight("@lsp.type.comment.documentation.attribute.quotes", {
  fg = color_table("red", 3),
  fg_dark = color_table("red", 9, { invert_dark = false }),
})
highlight("@lsp.type.comment.documentation.comment", { link = "@comment" })
highlight("@lsp.type.comment.documentation.delimiter", {
  fg = color_table("red", 3),
  fg_dark = color_table("red", 9, { invert_dark = false }),
})
highlight("@lsp.type.comment.documentation.name", {
  fg = color_table("orange", 4),
  fg_dark = color_table("orange", 9, { invert_dark = false }),
})
highlight("@lsp.type.comment.documentation.text", {
  link = "Material_SynDocComment",
})
highlight("@lsp.type.comment.excludedCode.cs", { link = "@comment" })
highlight("@lsp.type.delegate.cs", {
  link = "Material_SynAnonymousFunctionName",
})
highlight("@lsp.type.field.cs", { link = "Material_SynFieldName" })
highlight("@lsp.type.label.cs", { link = "Material_SynVariableName" })
highlight("@lsp.type.method.extension.cs", {
  link = "Material_SynExtensionMethod",
})
highlight("@lsp.type.operator.overloaded.cs", {
  link = "Material_SynOperatorOverloaded",
})
highlight("@lsp.type.preprocolors.text.cs", { link = "Normal" })
highlight("@lsp.type.property.cs", { link = "Material_SynPropertyName" })
highlight("@lsp.type.string.escape", { link = "Material_SynSpecialChar" })
highlight("@lsp.type.string.verbatim", { link = "Material_SynStringVerbatim" })

-- css {{{3

highlight("cssBraces", { link = "Material_SynSpecial" })
highlight("cssClassName", { link = "Material_SynTypedefName" })
highlight("cssFunction", { link = "NONE" })
highlight("cssIdentifier", { link = "Material_SynTypedefKeyword" })
highlight("cssImportant", { link = "Material_SynStatement" })
highlight("cssNoise", { link = "Material_SynSpecial" })
highlight("cssSelectorOp", { link = "Material_SynOperator" })

-- Treesitter {{{4

highlight("@property.css", { link = "Material_SynFieldNameNonItalic" })
highlight("@type.css", { link = "Material_SynStatement" })

-- dosini {{{3

highlight("dosiniLabel", { link = "Material_SynFieldNameNonItalic" })

-- fish {{{3

highlight("fishStatement", { link = "Material_SynFunctionName" })

-- gitcommit {{{3

highlight("gitCommitBlank", { link = "Material_VimStyleErrorUnderline" })
highlight("gitcommitOverflow", { link = "Material_VimStyleWarningUnderline" })

-- groovy {{{3

highlight("groovyParen", { link = "Material_SynSpecial" })
highlight("groovyParen1", { link = "Material_SynSpecial" })
highlight("groovyParen2", { link = "Material_SynSpecial" })
highlight("groovyInterpolatedString", { link = "Material_VimNormal" })
highlight("groovyInterpolatedWrapper", { link = "Material_SynSpecialChar" })

-- html {{{3

highlight("htmlArg", { link = "Material_SynFieldNameNonItalic" })
highlight("htmlEndTag", { link = "Material_SynSpecial" })
highlight("htmlTag", { link = "Material_SynSpecial" })

-- Treesitter {{{4

highlight("@tag.attribute.html", { link = "Material_SynFieldNameNonItalic" })

-- java {{{3

highlight("javaAnnotation", { link = "Material_SynDecorator" })
highlight("javaBraces", { link = "Material_SynSpecial" })
highlight("javaC_", { link = "Material_SynTypedefName" })
highlight("javaClassDecl", { link = "Material_SynTypedefKeyword" })
highlight("javaDocParam", { link = "Material_SynParameterName" })
highlight("javaLangObject", { link = "Material_SynFunctionName" })
highlight("javaParen", { link = "Material_SynSpecial" })
highlight("javaParen1", { link = "Material_SynSpecial" })
highlight("javaParen2", { link = "Material_SynSpecial" })
highlight("javaR_", { link = "Material_SynTypedefName" })
highlight("javaX_", { link = "Material_SynTypedefName" })

-- LSP {{{4

highlight("@lsp.type.annotationMember", { link = "Material_SynMemberName" })

-- javascript {{{3

highlight("jsArrowFunction", { link = "Material_SynFunctionKeyword" })
highlight("jsBrackets", { link = "Material_SynSpecial" })
highlight("jsClassBraces", { link = "Material_SynSpecial" })
highlight("jsClassDefinition", { link = "Material_SynTypedefName" })
highlight("jsDestructuringBraces", { link = "Material_SynSpecial" })
highlight("jsDot", { link = "Material_SynOperator" })
highlight("jsFuncArgCommas", { link = "Material_SynSpecial" })
highlight("jsFuncArgs", { link = "Material_SynParameterName" })
highlight("jsFuncBraces", { link = "Material_SynSpecial" })
highlight("jsFuncParens", { link = "Material_SynSpecial" })
highlight("jsFunction", { link = "Material_SynFunctionKeyword" })
highlight("jsFunctionKey", { link = "Material_SynFunctionName" })
highlight("jsIfElseBraces", { link = "Material_SynSpecial" })
highlight("jsModuleBraces", { link = "Material_SynSpecial" })
highlight("jsNoise", { link = "Material_SynSpecial" })
highlight("jsObjectBraces", { link = "Material_SynStructureKeyword" })
highlight("jsObjectColon", { link = "Material_SynSpecial" })
highlight("jsObjectKey", { link = "Material_SynFieldName" })
highlight("jsObjectProp", { link = "Material_SynFieldName" })
highlight("jsObjectSeparator", { link = "Material_SynSpecial" })
highlight("jsParens", { link = "Material_SynSpecial" })
highlight("jsRepeatBraces", { link = "Material_SynSpecial" })
highlight("jsSwitchBraces", { link = "Material_SynSpecial" })
highlight("jsSwitchColon", { link = "Material_SynSpecial" })
highlight("jsThis", { link = "Material_SynStatement" })
highlight("jsTryCatchBraces", { link = "Material_SynSpecial" })
highlight("jsVariableDef", { link = "Material_SynVariableName" })

-- json {{{3

highlight("jsonKeyword", { link = "Material_SynFieldNameNonItalic" })
highlight("jsonNoise", { link = "Material_SynSpecial" })
highlight("jsonNull", { link = "Material_SynConstant" })

-- jsonc {{{3

highlight("jsoncBraces", { link = "Material_SynSpecial" })
highlight("jsoncKeywordMatch", { link = "Material_SynFieldNameNonItalic" })

-- JSP {{{3

highlight("jspTag", { link = "Material_SynPreProc" })

-- lua {{{3

highlight("luaFuncCall", { link = "Material_SynFunctionName" })
highlight("luaFuncKeyword", { link = "Material_SynFunctionKeyword" })

-- LSP {{{4

highlight("@lsp.type.comment.lua", { fg = "NONE" })

-- make {{{3

highlight("makeCommands", { link = "Material_SynConstant" })

-- markdown {{{3

highlight("mkdCodeDelimiter", { link = "Material_SynSpecialChar" })
highlight("mkdCodeEnd", { link = "Material_SynSpecialChar" })
highlight("mkdCodeStart", { link = "Material_SynSpecialChar" })
highlight("mkdHeading", { link = "Material_SynSpecial" })
highlight("mkdListItem", { link = "Material_SynSpecial" })

-- mustache/handlebars {{{3

highlight("mustacheHelpers", { link = "Material_SynOperator" })
highlight("mustacheHbsComponent", { link = "Material_SynFieldName" })

-- razor {{{3

highlight("razorcsIdentifier", { link = "Material_SynStructureName" })
highlight("razorHtmlAttribute", { link = "@tag.attribute.html" })
highlight("razorHtmlTag", { link = "@tag.html" })

-- ruby {{{3

highlight("rubyClass", { link = "Material_SynTypedefKeyword" })
highlight("rubyClassName", { link = "Material_SynTypedefName" })
highlight("rubyConstant", { link = "Material_SynTypedefName" })
highlight("rubyModule", { link = "Material_SynNamespaceKeyword" })
highlight("rubyModuleName", { link = "Material_SynNamespaceName" })
highlight("rubyPredefinedConstant", { link = "Material_SynConstantName" })
highlight("rubyPseudoOperator", { link = "Material_SynOperator" })
highlight("rubyStringDelimiter", { link = "Material_SynSpecialChar" })

-- rust {{{3

highlight("rustEnumVariant", { link = "Material_SynEnumMember" })
highlight("rustEnum", { link = "Material_SynEnumName" })
highlight("rustModPath", { link = "Material_SynNamespaceName" })
highlight("rustStructure", { link = "Material_SynStructureKeyword" })
highlight("rustType", { link = "Material_SynTypedefName" })

-- sh {{{3

highlight("shCmdSubRegion", { link = "Material_SynSpecial" })
highlight("shDeref", { link = "Material_SynSpecial" })
highlight("shDerefSimple", { link = "Material_SynVariableName" })
highlight("shDerefVar", { link = "Material_SynVariableName" })
highlight("shOption", { link = "Material_SynParameterName" })
highlight("shStatement", { link = "Material_SynFunctionName" })
highlight("shQuote", { link = "Material_SynSpecialChar" })
highlight("shVariable", { link = "Material_SynVariableName" })

-- Typescript {{{3

highlight("typescriptAliasDeclaration", { link = "Material_SynTypedefName" })
highlight("typescriptAliasKeyword", { link = "Material_SynTypedefKeyword" })
highlight("typescriptAmbientDeclaration", { link = "Material_SynStatement" })
highlight("typescriptArrowFunc", { link = "Material_SynFunctionKeyword" })
highlight("typescriptAssign", { link = "Material_SynOperator" })
highlight("typescriptBinaryOp", { link = "Material_SynOperator" })
highlight("typescriptBraces", { link = "Material_SynSpecial" })
highlight("typescriptCall", { link = "Material_SynParameterName" })
highlight("typescriptClassKeyword", { link = "Material_SynTypedefKeyword" })
highlight("typescriptClassName", { link = "Material_SynTypedefName" })
highlight("typescriptClassTypeParameter", {
  link = "Material_SynGenericBackground",
})
highlight("typescriptDecorator", { link = "Material_SynDecorator" })
highlight("typescriptDotNotation", { link = "Material_SynOperator" })
highlight("typescriptEndColons", { link = "Material_SynSpecial" })
highlight("typescriptEnumKeyword", { link = "Material_SynEnumKeyword" })
highlight("typescriptExceptions", { link = "Material_SynStatement" })
highlight("typescriptExport", { link = "Material_SynStatement" })
highlight("typescriptFuncComma", { link = "Material_SynSpecial" })
highlight("typescriptGlobalMathDot", { link = "Material_SynOperator" })
highlight("typescriptGlobalPromiseDot", { link = "Material_SynOperator" })
highlight("typescriptIdentifierName", { link = "Material_SynStructureName" })
highlight("typescriptImport", { link = "Material_SynStatement" })
highlight("typescriptInterfaceKeyword", {
  link = "Material_SynInterfaceKeyword",
})
highlight("typescriptInterfaceName", { link = "Material_SynInterfaceName" })
highlight("typescriptMember", { link = "Material_SynFieldName" })
highlight("typescriptMemberOptionality", { link = "Material_SynOperator" })
highlight("typescriptModule", { link = "Material_SynNamespaceKeyword" })
highlight("typescriptNull", { link = "Material_SynConstant" })
highlight("typescriptObjectColon", { link = "Material_SynSpecial" })
highlight("typescriptObjectLabel", { link = "Material_SynFieldName" })
highlight("typescriptOptionalMark", { link = "Material_SynOperator" })
highlight("typescriptParens", { link = "Material_SynSpecial" })
highlight("typescriptPredefinedType", { link = "Material_SynTypeName" })
highlight("typescriptProp", { link = "Material_SynPropertyName" })
highlight("typescriptRestOrSpread", { link = "Material_SynOperator" })
highlight("typescriptTry", { link = "Material_SynStatement" })
highlight("typescriptTypeAnnotation", { link = "Material_SynSpecial" })
highlight("typescriptTypeBracket", { link = "Material_SynSpecial" })
highlight("typescriptTypeBrackets", { link = "Material_SynGenericSpecial" })
highlight("typescriptTypeParameter", {
  link = "Material_SynGenericParameterName",
})
highlight("typescriptVariable", { link = "Material_SynStatement" })
highlight("typescriptVariableDeclaration", {
  link = "Material_SynVariableName",
})

-- vim (VimScript|VimL) {{{3

highlight("vimCommentString", { fg = color_table("green", 5) })
highlight("vimEnvvar", { link = "Material_SynStructureName" })
highlight("vimFunction", { link = "Material_SynFunctionName" })
highlight("vimHiBang", { link = "Material_SynSpecial" })
highlight("vimUserFunc", { link = "Material_SynFunctionName" })

-- xml {{{3

highlight("xmlAttrib", { link = "Material_SynFieldNameNonItalic" })
highlight("xmlAttribPunct", { link = "Material_SynSpecial" })
highlight("xmlEqual", { link = "Material_SynOperator" })
highlight("xmlNamespace", { link = "Material_SynNamespaceName" })
highlight("xmlTag", { link = "Material_SynSpecial" })
highlight("xmlTagName", { link = "Material_SynStatement" })

-- yaml {{{3

highlight("yamlBlockMappingKey", { link = "Material_SynFieldName" })

-- yardoc {{{3

-- Fix the wrongly linked groups in noprompt/vim-yardocolors.
highlight("yardYield", { link = "yardGenericTag" })
highlight("yardYieldParam", { link = "yardGenericTag" })
highlight("yardYieldReturn", { link = "yardGenericTag" })

-- Customize some highlight groups for noprompt/vim-yardocolors.
highlight("yardDuckType", { link = "Material_SynFunctionName" })
highlight("yardGenericTag", { link = "Material_SynSpecial" })
highlight("yardLiteral", { link = "Material_SynConstant" })
highlight("yardParamName", { link = "Material_SynParameterName" })
highlight("yardType", { link = "Material_SynTypedefName" })

-- zsh {{{3

highlight("zshFlag", { link = "Material_SynParameterName" })

-- highlight groups for plugins {{{2

-- csv | chrisbra/csv {{{3

highlight("CSVColumnHeaderOdd", { link = "Material_VimTitle" })
highlight("CSVColumnHeaderEven", { link = "Material_VimTitle" })

-- diffview | sindrets/diffview.nvim {{{3

highlight("DiffviewStatusAdded", { link = "Material_VimDiffSignAdd" })
highlight("DiffviewStatusModified", { link = "Material_VimDiffSignChange" })
highlight("DiffviewStatusDeleted", { link = "Material_VimDiffSignDelete" })

-- fidget | j-hui/fidget.nvim {{{3

highlight("FidgetTask", { link = "Material_SynComment" })

-- gitsigns | lewis6991/gitsigns.nvim {{{3

highlight("GitSignsAdd", { link = "Material_VimDiffSignAdd" })
highlight("GitSignsAddInline", { link = "Material_VimDiffLineText" })
highlight("GitSignsChange", { link = "Material_VimDiffSignChange" })
highlight("GitSignsChangeInline", { link = "Material_VimDiffLineText" })
highlight("GitSignsChangeDelete", { link = "Material_VimDiffSignChangeDelete" })
highlight("GitSignsChangeDeleteLn", {
  link = "Material_VimDiffLineChangeDelete",
})
highlight("GitSignsDelete", { link = "Material_VimDiffSignDelete" })
highlight("GitSignsDeleteInline", { link = "Material_VimDiffLineText" })

-- indent-blankline | lukas-reineke/indent-blankline.nvim {{{3

highlight("IblIndent", {
  fg = color_table(hues.neutral, 3),
  italic = false,
  bold = false,
  nocombine = true,
})
highlight("IblScope", {
  fg = color_table(hues.neutral, 4),
  italic = false,
  bold = false,
  nocombine = true,
})

-- log | MTDL9/vim-log-Highlighting {{{3

highlight("logLevelTrace", { link = "Material_VimTraceInverted" })
highlight("logLevelDebug", { link = "Material_VimDebugInverted" })
highlight("logLevelNotice", { link = "Material_VimHintInverted" })
highlight("logLevelInfo", { link = "Material_VimInfoInverted" })
highlight("logLevelWarning", { link = "Material_VimWarningInverted" })
highlight("logLevelError", { link = "Material_VimErrorInverted" })

highlight("logBrackets", { link = "Material_SynSpecial" })

highlight("logXmlNamespace", { link = "Material_SynNamespaceName" })

-- lualine | nvim-lualine/lualine.nvim {{{3

highlight("Material_Lualine1", {
  fg = colors.neutral.midpoint_strong,
  bg = color_table(hues.neutral, 2),
})
highlight("Material_Lualine3", {
  fg = colors.neutral.lightest,
  bg = colors.neutral.strong,
})

highlight("Material_LualineInsert", {
  fg = colors.neutral.lightest,
  bg = color_table(hues.insert, 7),
  bold = true,
})
highlight("Material_LualineReplace", {
  fg = colors.neutral.lightest,
  bg = color_table(hues.replace, 7),
  bold = true,
})

highlight("Material_LualineModified", {
  fg = colors.neutral.lightest,
  bg = colors.modified.strong,
})
highlight("Material_LualineLazyPackages", {
  fg = colors.syntax.namespace,
  bg = colors.neutral.strong,
})

-- neo-tree | nvim-neo-tree/neo-tree.nvim {{{3

highlight("NeoTreeModified", { fg = colors.modified.strong })
highlight("NeoTreeGitStaged", {
  fg = colors.neutral.lightest,
  bg = colors.git.staged,
})
highlight("NeoTreeGitIgnored", { link = "Material_SynComment" })
highlight("NeoTreeGitUnstaged", {
  fg = colors.neutral.lightest,
  bg = colors.git.unstaged,
})
highlight("NeoTreeGitUntracked", {
  fg = colors.neutral.lightest,
  bg = colors.git.untracked,
})

-- nvim-cmp | hrsh7th/nvim-cmp {{{3

highlight("CmpItemAbbrDeprecated", { link = "Material_SynModDeprecated" })
highlight("CmpItemAbbrMatch", { bold = true })

highlight("CmpItemKindClass", { link = "Material_SynTypedefName" })
highlight("CmpItemKindConstant", { link = "Material_SynConstantName" })
highlight("CmpItemKindConstructor", { link = "Material_SynFunctionName" })
highlight("CmpItemKindEnum", { link = "Material_SynEnumName" })
highlight("CmpItemKindEnumMember", { link = "Material_SynEnumMember" })
highlight("CmpItemKindField", { link = "Material_SynFieldName" })
highlight("CmpItemKindFolder", { link = "Material_VimDirectory" })
highlight("CmpItemKindFunction", { link = "Material_SynFunctionName" })
highlight("CmpItemKindInterface", { link = "Material_SynInterfaceName" })
highlight("CmpItemKindKeyword", { link = "Material_SynStatement" })
highlight("CmpItemKindMethod", { link = "Material_SynFunctionName" })
highlight("CmpItemKindModule", { link = "Material_SynNamespaceName" })
highlight("CmpItemKindOperator", { link = "Material_SynOperator" })
highlight("CmpItemKindProperty", { link = "Material_SynPropertyName" })
highlight("CmpItemKindStruct", { link = "Material_SynStructureName" })
highlight("CmpItemKindTypeParameter", {
  link = "Material_SynGenericParameterName",
})
highlight("CmpItemKindVariable", { link = "Material_SynVariableName" })

-- nvim-navic | SmiteshP/nvim-navic {{{3

highlight("NavicIconsArray", {
  fg = h_syn_structure_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsBoolean", {
  fg = h_syn_boolean.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsClass", {
  fg = h_syn_typedef_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsConstant", {
  fg = h_syn_constant_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsConstructor", {
  fg = h_syn_function_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsEnum", {
  fg = colors.syntax.enum.name,
  bg = colors.neutral.strong,
})
highlight("NavicIconsEnumMember", {
  fg = colors.syntax.enum.member,
  bg = colors.neutral.strong,
})
highlight("NavicIconsEvent", { link = "Material_DebugTest" })
highlight("NavicIconsField", {
  fg = h_syn_field_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsFile", { link = "Material_Lualine3" })
highlight("NavicIconsFunction", {
  fg = h_syn_function_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsInterface", {
  fg = h_syn_interface_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsKey", {
  fg = h_syn_statement.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsMethod", {
  fg = h_syn_function_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsModule", {
  fg = h_syn_namespace_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsNamespace", {
  fg = h_syn_namespace_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsNull", {
  fg = h_syn_constant.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsNumber", {
  fg = h_syn_number.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsObject", {
  fg = h_syn_structure_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsOperator", {
  fg = h_syn_operator.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsPackage", {
  fg = h_syn_namespace_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsProperty", {
  fg = h_syn_property_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsString", {
  fg = h_syn_string.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsStruct", {
  fg = h_syn_structure_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsTypeParameter", {
  fg = h_syn_generic_parameter_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicIconsVariable", {
  fg = h_syn_variable_name.fg,
  bg = colors.neutral.strong,
})
highlight("NavicSeparator", { link = "Material_Lualine3" })
highlight("NavicText", { link = "Material_Lualine3" })

-- nvim-notify | rcarriga/nvim-notify {{{3

highlight("NotifyBackground", { link = "Material_VimPopup" })
highlight("NotifyDEBUGBorder", { link = "Material_VimDebugBorder" })
highlight("NotifyDEBUGIcon", { link = "Material_VimDebug" })
highlight("NotifyDEBUGTitle", { link = "Material_VimDebug" })
highlight("NotifyERRORBorder", { link = "Material_VimErrorBorder" })
highlight("NotifyERRORIcon", { link = "Material_VimError" })
highlight("NotifyERRORTitle", { link = "Material_VimError" })
highlight("NotifyINFOBorder", { link = "Material_VimInfoBorder" })
highlight("NotifyINFOIcon", { link = "Material_VimInfo" })
highlight("NotifyINFOTitle", { link = "Material_VimInfo" })
highlight("NotifyTRACEBorder", { link = "Material_VimTraceBorder" })
highlight("NotifyTRACEIcon", { link = "Material_VimTrace" })
highlight("NotifyTRACETitle", { link = "Material_VimTrace" })
highlight("NotifyWARNBorder", { link = "Material_VimWarningBorder" })
highlight("NotifyWARNIcon", { link = "Material_VimWarning" })
highlight("NotifyWARNTitle", { link = "Material_VimWarning" })

-- oil-git-status | refractalize/oil-git-status.nvim {{{3

highlight("OilGitStatusIndexUnmodified", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexIgnored", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexUntracked", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexAdded", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexCopied", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexDeleted", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexModified", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexRenamed", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexTypeChanged", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusIndexUnmerged", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeUnmodified", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeIgnored", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeUntracked", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeAdded", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeCopied", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeDeleted", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeModified", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeRenamed", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeTypeChanged", {
  link = "Material_VimLightFramingSubtleFg",
})
highlight("OilGitStatusWorkingTreeUnmerged", {
  link = "Material_VimLightFramingSubtleFg",
})

-- vim-git | tpope/vim-git {{{3

highlight("diffAdded", { link = "Material_VimDiffAdd" })
highlight("diffRemoved", { link = "Material_VimDiffDelete" })

-- vim-illuminate | RRethy/vim-illuminate {{{3

highlight("IlluminatedWordText", { link = "Material_LspReferenceText" })
highlight("IlluminatedWordRead", { link = "Material_LspReferenceRead" })
highlight("IlluminatedWordWrite", { link = "Material_LspReferenceWrite" })
