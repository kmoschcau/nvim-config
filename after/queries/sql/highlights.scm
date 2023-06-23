;; extends

; table refs

(object_reference
  schema: (identifier) @namespace)

; column refs

(column
  (identifier) @field)

(column_definition
  name: (identifier) @field)

(column_position
  col_name: (identifier) @field)

(drop_column
  name: (identifier) @field)

(field
  name: (identifier) @field)

; indices

(drop_index
  name: (identifier) @decorator)

; keywords

(column_definition
  (keyword_null) @constant.builtin)

(literal
  (keyword_null) @constant.builtin)

; operators

(keyword_like) @keyword.operator

; special characters

(identifier
  "`" @punctuation.delimiter)
