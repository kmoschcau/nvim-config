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

; generics

(generic_type
  (type_arguments
    ["<" ">"] @generic.special))

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

; type references

(class_declaration
  interfaces: (super_interfaces
    (interface_type_list
      [(type_identifier) @interface.name
       (generic_type
        (type_identifier) @interface.name)])))
