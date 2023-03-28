local lsp = require "plugins.config.lsp"
local util = require("lspconfig").util

local function create_base_cmd()
  return {
    "OmniSharp",
    "--hostPID",
    tostring(vim.fn.getpid()),
    "--zero-based-indices",
    "--languageserver",
  }
end

local function create_token_modifiers()
  return { "static" }
end

local function create_token_types()
  return {
    "comment", -- comment
    "comment.excludedCode", -- excluded code
    "identifier", -- identifier
    "keyword", -- keyword
    "conditional", -- keyword - control
    "number", -- number
    "operator", -- operator
    "operator.overloaded", -- operator - overloaded
    "preproc", -- preprocessor keyword
    "string", -- string
    "whitespace", -- whitespace
    "text", -- text
    "static", -- static symbol
    "preproc.text", -- preprocessor text
    "punctuation", -- punctuation
    "string.verbatim", -- string - verbatim
    "string.escape", -- string - escape character
    "class", -- class name
    "delegate", -- delegate name
    "enum", -- enum name
    "interface", -- interface name
    "module", -- module name
    "struct", -- struct name
    "typeParameter", -- type parameter name
    "field", -- field name
    "enumMember", -- enum member name
    "constant", -- constant name
    "variable", -- local name
    "parameter", -- parameter name
    "method", -- method name
    "method.extension", -- extension method name
    "property", -- property name
    "event", -- event name
    "namespace", -- namespace name
    "label", -- label name
    "comment.documentation.attribute.name", -- xml doc comment - attribute name
    "comment.documentation.attribute.quotes", -- xml doc comment - attribute quotes
    "comment.documentation.attribute.value", -- xml doc comment - attribute value
    "comment.documentation.cdata", -- xml doc comment - cdata section
    "comment.documentation.comment", -- xml doc comment - comment
    "comment.documentation.delimiter", -- xml doc comment - delimiter
    "comment.documentation.entityReference", -- xml doc comment - entity reference
    "comment.documentation.name", -- xml doc comment - name
    "comment.documentation.processingInstruction", -- xml doc comment - processing instruction
    "comment.documentation.text", -- xml doc comment - text
    "xml.attribute.name", -- xml literal - attribute name
    "xml.attribute.quotes", -- xml literal - attribute quotes
    "xml.attribute.value", -- xml literal - attribute value
    "xml.cdata", -- xml literal - cdata section
    "xml.comment", -- xml literal - comment
    "xml.delimiter", -- xml literal - delimiter
    "xml.embeddedExpression", -- xml literal - embedded expression
    "xml.entityReference", -- xml literal - entity reference
    "xml.name", -- xml literal - name
    "xml.processingInstruction", -- xml literal - processing instruction
    "xml.text", -- xml literal - text
    "regexp.comment", -- regex - comment
    "regexp.characterClass", -- regex - character class
    "regexp.anchor", -- regex - anchor
    "regexp.quantifier", -- regex - quantifier
    "regexp.grouping", -- regex - grouping
    "regexp.alternation", -- regex - alternation
    "regexp.text", -- regex - text
    "regexp.selfEscapedCharacter", -- regex - self escaped character
    "regexp.escape", -- regex other escape
  }
end

local function link_fallback_highlight(full, prefixed)
  vim.api.nvim_set_hl(0, "@" .. full, {
    default = true,
    link = "@" .. prefixed,
  })
end

local function create_decorated_token_modifiers()
  return vim.tbl_map(function(mod)
    local prefixed = "lsp.mod." .. mod
    local full = prefixed .. ".cs"
    link_fallback_highlight(full, prefixed)
    return full
  end, create_token_modifiers())
end

local function create_decorated_token_types()
  return vim.tbl_map(function(mod)
    local prefixed = "lsp.type." .. mod
    local full = prefixed .. ".cs"
    link_fallback_highlight(full, prefixed)
    return full
  end, create_token_types())
end

require("lspconfig").omnisharp.setup {
  cmd = create_base_cmd(),
  capabilities = lsp.capabilities,
  handlers = lsp.handlers,
  root_dir = function(fname)
    -- TODO: Add selection when multiple found
    vim.notify("Omnisharp fname: " .. fname, vim.log.levels.DEBUG)
    local root_dir = util.root_pattern "*.sln"(fname)
      or util.root_pattern "*.csproj"(fname)
    vim.notify(
      "Omnisharp root_dir: " .. tostring(root_dir),
      vim.log.levels.DEBUG
    )
    return root_dir
  end,
  on_new_config = function(new_config, new_root_dir)
    if new_root_dir == nil then
      return
    end
    new_config.cmd = create_base_cmd()
    vim.list_extend(new_config.cmd, { "--source", new_root_dir })
  end,
  on_attach = function(client)
    -- This is needed because OmniSharp's semantic tokens don't comply with LSP
    -- FIXME: This needs to be changed to only the types once choco nvim has enhanced lsp client highlights
    client.server_capabilities.semanticTokensProvider.legend = {
      tokenModifiers = create_decorated_token_modifiers(),
      tokenTypes = create_decorated_token_types(),
    }
  end,
}
