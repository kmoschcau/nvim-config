;; extends

; namespaces

(ambient_declaration
  "global" @namespace)

(internal_module
  "namespace" @keyword.namespace
  name: (identifier) @namespace)

; generics

(type_arguments
  ["<" ">"] @generic.special)

(type_parameters
  ["<" ">"] @generic.special)

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
  name: (property_identifier) @function)

(method_definition
  ["get" "set"] @keyword.property
  name: (property_identifier) @property)

(interface_declaration
  "interface" @keyword.interface
  name: (type_identifier) @interface)

(abstract_class_declaration
  "class" @keyword.class
  name: (type_identifier) @class)

(class_declaration
  "class" @keyword.class
  name: (type_identifier) @class)
