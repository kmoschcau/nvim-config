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
  ] @keyword.property
  name: (property_identifier) @property)

(class_declaration
  "class" @keyword.class)
