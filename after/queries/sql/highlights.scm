; extends

(object_reference
  schema: (identifier) @module)

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

(drop_index
  name: (identifier) @attribute)

(column_definition
  (keyword_null) @constant.builtin)

(literal
  (keyword_null) @constant.builtin)

(keyword_like) @keyword.operator
