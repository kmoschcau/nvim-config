; extends

; keywords

(lambda_expression
  (modifier) @keyword.coroutine)

; operators

(binary_expression
  operator: _ @operator)

; namespaces

(extern_alias_directive
  "extern" @keyword.import
  "alias" @keyword.import
  name: (_) @module)

(using_directive
  "global" @keyword)

(using_directive
  name: (identifier) @module)

(qualified_name
  qualifier: (identifier) @module)

(file_scoped_namespace_declaration
  "namespace" @keyword.module)

(namespace_declaration
  "namespace" @keyword.module)

; type declarations

(class_declaration
  "class" @keyword.class)

(interface_declaration
  "interface" @keyword.interface)

(enum_declaration
  "enum" @keyword.enum)

(accessor_declaration
  name: ["get" "set"] @keyword.property)
