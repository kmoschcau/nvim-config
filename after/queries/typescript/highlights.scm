; namespaces

(ambient_declaration
  "global" @namespace.name)

(internal_module
  "namespace" @namespace.keyword
  name: (identifier) @namespace.name)

; generics

(generic_type
  (type_arguments
    ["<" ">"] @generic.special))

; type declarations

(lexical_declaration
  "const"
  (variable_declarator
    name: (identifier) @constant))

(for_in_statement
  "const"
  left: (identifier) @constant)

(lexical_declaration
  "let"
  (variable_declarator
    name: (identifier) @local.name))

(for_in_statement
  "let"
  left: (identifier) @local.name)

(method_signature
  name: (property_identifier) @function.name)

(method_definition
  ["get" "set"] @accessor.keyword
  name: (property_identifier) @accessor.name)

(interface_declaration
  "interface" @interface.keyword
  name: (type_identifier) @interface.name)

(abstract_class_declaration
  "class" @class.keyword
  name: (type_identifier) @class.name)

(class_declaration
  "class" @class.keyword
  name: (type_identifier) @class.name)
