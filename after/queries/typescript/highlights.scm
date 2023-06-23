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

(method_signature
  ["get" "set"] @keyword.property
  name: (property_identifier) @accessor)

(method_definition
  ["get" "set"] @keyword.property
  name: (property_identifier) @accessor)

(interface_declaration
  "interface" @keyword.interface
  name: (type_identifier) @interface)

(abstract_class_declaration
  "class" @keyword.class
  name: (type_identifier) @class)

(class_declaration
  "class" @keyword.class
  name: (type_identifier) @class)
