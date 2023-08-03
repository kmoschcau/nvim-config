local common = require "plugins.config.lsp.common"
local compat = require "system-compat"
local omni_ext = require "omnisharp_extended"

require("lspconfig").omnisharp.setup {
  cmd = { compat.append_win_ext "omnisharp" },
  capabilities = common.capabilities,
  handlers = vim.tbl_extend(
    "error",
    common.handlers,
    { ["textDocument/definition"] = omni_ext.handler }
  ),
}

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Set up OmniSharp specific things when attaching with a language client to it.",
  group = common.augroup,
  --- @param args LspAttachArgs the autocmd args
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.name ~= "omnisharp" then
      return
    end

    -- textDocument/definition
    vim.keymap.set("n", "gd", omni_ext.telescope_lsp_definitions, {
      buffer = args.buf,
      desc = "Fuzzy find definitions of the symbol under the cursor.",
      silent = true,
    })

    -- This is needed because OmniSharp's semantic tokens are off-spec
    client.server_capabilities.semanticTokensProvider.legend = {
      tokenModifiers = {
        "static", -- static
      },
      tokenTypes = {
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
      },
    }
  end,
})
