;; extends

; operators

(unary_expression
  operator: "!" @operator)

(method_invocation
  "." @operator)

(scoped_identifier
  "." @operator)

; namespaces

(package_declaration
  "package" @keyword.namespace
  (scoped_identifier
    name: (identifier) @namespace))

(import_declaration
  (scoped_identifier
    name: (identifier) @type))

(scoped_identifier
  (scoped_identifier
    (identifier) @namespace))

; generics

(generic_type
  (type_arguments
    ["<" ">"] @generic.special))

; type declarations

(enum_declaration
  "enum" @keyword.enum
  name: (identifier) @enum)

(enum_constant
  name: (identifier) @enum)

(interface_declaration
  "interface" @keyword.interface
  name: (identifier) @interface)

(class_declaration
  "class" @keyword.class
  name: (identifier) @class)

; type references

(class_declaration
  interfaces: (super_interfaces
    (type_list
      [(type_identifier) @interface
       (generic_type
        (type_identifier) @interface)])))
