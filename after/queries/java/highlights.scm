; operators

(unary_expression
  operator: "!" @operator)

(method_invocation
  "." @operator)

(scoped_identifier
  "." @operator)

; namespaces

(package_declaration
  "package" @namespace.keyword
  (scoped_identifier
    name: (identifier) @namespace.name))

(import_declaration
  (scoped_identifier
    name: (identifier) @type))

(scoped_identifier
  (scoped_identifier
    (identifier) @namespace.name))

; annotations

[
  (marker_annotation)
  (annotation)
] @annotation

; type declarations

(enum_declaration
  "enum" @enum.keyword
  name: (identifier) @enum.name)

(enum_constant
  name: (identifier) @enum.name)

(interface_declaration
  "interface" @interface.keyword
  name: (identifier) @interface.name)

(class_declaration
  "class" @class.keyword
  name: (identifier) @class.name)
