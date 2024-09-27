; extends

; namespaces
(ambient_declaration
  "global" @module)

(internal_module
  "namespace" @keyword.module
  name: (identifier) @module)

; generics
(type_arguments
  [
    "<"
    ">"
  ] @generic.special)

(type_parameters
  [
    "<"
    ">"
  ] @generic.special)

; type declarations
(method_signature
  [
    "get"
    "set"
  ] @keyword.property
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
