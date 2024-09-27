; extends

(lexical_declaration
  "const"
  (variable_declarator
    name: (identifier) @constant))

(for_in_statement
  "const"
  left: (identifier) @constant)

(method_definition
  [
    "get"
    "set"
  ] @keyword.property)
