local common = require "plugins.config.lsp.common"
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

--- @param message string
local function notify_root(message)
  vim.notify(
    message,
    vim.log.levels.DEBUG,
    { title = "OmniSharp get_root_dir" }
  )
end

local function get_root_dir(fname)
  notify_root("fname: " .. fname)

  local root_dir = util.root_pattern "*.sln"(fname)
    or util.root_pattern "*.csproj"(fname)

  notify_root("root_dir: " .. tostring(root_dir))

  return root_dir
end

--- @param message string
local function notify_select(message)
  vim.notify(
    message,
    vim.log.levels.DEBUG,
    { title = "OmniSharp select_source" }
  )
end

local function select_source(root_dir)
  if root_dir == nil then
    return nil
  end

  local sln_matches = vim.fn.glob(root_dir .. "/*.sln", false, true)
  local csproj_matches = vim.fn.glob(root_dir .. "/*.csproj", false, true)

  notify_select("sln_matches: " .. vim.inspect(sln_matches))
  notify_select("csproj_matches: " .. vim.inspect(csproj_matches))

  local matches = {}
  if not vim.tbl_isempty(sln_matches) then
    matches = sln_matches
  elseif not vim.tbl_isempty(csproj_matches) then
    matches = csproj_matches
  end

  notify_select("matches: " .. vim.inspect(matches))

  if #matches < 2 then
    notify_select "single result"
    return root_dir
  end

  local selection_counter = 0
  local selection_options = vim.list_extend(
    { "Select a source:", "0: " .. root_dir },
    vim.tbl_map(function(match)
      selection_counter = selection_counter + 1
      return tostring(selection_counter) .. ": " .. match
    end, matches)
  )

  notify_select("selection_list: " .. vim.inspect(selection_options))

  local selection = vim.fn.inputlist(selection_options)

  notify_select("user selection: " .. selection)

  if selection < 2 then
    notify_select("using root_dir: " .. root_dir)
    return root_dir
  end

  local selected = matches[selection]

  notify_select("selected: " .. selected)

  return selected
end

require("lspconfig").omnisharp.setup {
  cmd = create_base_cmd(),
  capabilities = common.capabilities,
  handlers = common.handlers,
  root_dir = get_root_dir,
  on_new_config = function(new_config, new_root_dir)
    if new_root_dir == nil then
      return
    end
    new_config.cmd = create_base_cmd()
    vim.list_extend(new_config.cmd, { "--source", select_source(new_root_dir) })
  end,
  on_attach = function(client)
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
}
