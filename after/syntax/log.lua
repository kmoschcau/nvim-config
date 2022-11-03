vim.cmd [[
syntax clear logTime
syntax match logTime /\d\{2}:\d\{2}:\d\{2}\(\.\d\{2,6}\)\?\(\s\?[-+]\d\{2,4}\|Z\)\?\>/ nextgroup=logLevelTrace,logLevelDebug,logLevelNotice,logLevelInfo,logLevelWarning,logLevelError,logTimeZone,logSysColumns skipwhite

syntax keyword logLevelTrace Trace
syntax keyword logLevelDebug Debug
syntax keyword logLevelNotice Notice
syntax keyword logLevelInfo Info
syntax keyword logLevelWarning Warning Warn
syntax keyword logLevelError Error

syntax match logLevelInfo /\c\<info\>/

syntax match logReference /\<\h\w\+\.\.\?\h\w\+\%(\.\.\?\h\w\+\)*\>\%((.*)\)\?/ transparent
syntax match logReferenceType /\h\w\+/ contained containedin=logReference
syntax match logReferenceNamespace /\h\w\+\ze\./ contained containedin=logReference
syntax match logReferenceException /\%(\h\w\+\)\?\%(Exception\|Error\)\>/ contained containedin=logReferenceType
syntax match logReferenceDot /\./ contained containedin=logReference
syntax match logReferenceCall /(.*)/ contained containedin=logReference
syntax match logReferenceCallComma /\,/ contained containedin=logReferenceCall
syntax match logReferenceParens /(\|)/ contained containedin=logReferenceCall
syntax match logReferenceParam /\%(\h\w\+ \+\)\?\h\w\+/ contained containedin=logReferenceCall
syntax match logReferenceParamType /\h\w\+\ze \+\h\w/ contained containedin=logReferenceParam
syntax match logReferenceParamName /\h\w\+\ze\%(,\|)\)/ contained containedin=logReferenceParam
syntax match logReferenceJavaFileRef /\h\w\+\.java:\d\+/ contained containedin=logReferenceCall
syntax match logReferenceJavaFile /\h\w\+\.java/ contained containedin=logReferenceJavaFileRef
syntax match logReferenceJavaLineNumber /\d+/ contained containedin=logReferenceJavaFileRef
]]

vim.api.nvim_set_hl(0, "logReferenceType", {
  default = true,
  link = "Material_SynTypedefName",
})
vim.api.nvim_set_hl(0, "logReferenceNamespace", {
  default = true,
  link = "Material_SynNamespaceName",
})
vim.api.nvim_set_hl(0, "logReferenceException", {
  default = true,
  link = "Material_VimError",
})
vim.api.nvim_set_hl(0, "logReferenceDot", {
  default = true,
  link = "logOperator",
})
vim.api.nvim_set_hl(0, "logReferenceParens", {
  default = true,
  link = "Material_SynSpecial",
})
vim.api.nvim_set_hl(0, "logReferenceCallComma", {
  default = true,
  link = "Material_SynSpecial",
})
vim.api.nvim_set_hl(0, "logReferenceParamType", {
  default = true,
  link = "Material_SynTypedefName",
})
vim.api.nvim_set_hl(0, "logReferenceParamName", {
  default = true,
  link = "Material_SynParameterName",
})
vim.api.nvim_set_hl(0, "logReferenceJavaFile", {
  default = true,
  link = "logFilePath",
})
vim.api.nvim_set_hl(0, "logReferenceJavaLineNumber", {
  default = true,
  link = "logNumber",
})
