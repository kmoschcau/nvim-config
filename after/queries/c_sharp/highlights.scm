;; extends

; operators

(binary_expression
  operator: _ @operator)

; namespaces

(extern_alias_directive
  "extern" @include
  "alias" @include
  name: (_) @namespace)

(using_directive
  "global" @keyword)

(using_directive
  name: (identifier) @namespace)

(qualified_name
  qualifier: (identifier) @namespace)

(file_scoped_namespace_declaration
  "namespace" @keyword.namespace)

(namespace_declaration
  "namespace" @keyword.namespace)

; type declarations

(class_declaration
  "class" @keyword.class)

(interface_declaration
  "interface" @keyword.interface)

(enum_declaration
  "enum" @keyword.enum)

(accessor_declaration
  name: ["get" "set"] @keyword.property)
