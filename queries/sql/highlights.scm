; extends

; table refs

(object_reference
  schema: (identifier) @module)

; column refs

(column
  (identifier) @variable.member)

(column_definition
  name: (identifier) @variable.member)

(column_position
  col_name: (identifier) @variable.member)

(drop_column
  name: (identifier) @variable.member)

(field
  name: (identifier) @variable.member)

; indices

(drop_index
  name: (identifier) @attribute)

; keywords

(column_definition
  (keyword_null) @constant.builtin)

(literal
  (keyword_null) @constant.builtin)

; operators

(keyword_like) @keyword.operator
