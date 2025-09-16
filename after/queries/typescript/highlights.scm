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
  ] @punctuation.special)

(type_parameters
  [
    "<"
    ">"
  ] @punctuation.special)

(interface_declaration
  "interface" @keyword.interface
  name: (type_identifier) @interface)

(abstract_class_declaration
  "class" @keyword.class)

(this_type) @type.builtin
