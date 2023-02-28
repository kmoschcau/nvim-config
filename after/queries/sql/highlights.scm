;; extends

; table refs

(table_reference
  schema: (identifier) @namespace
  name: (identifier) @type)

; column refs

(column
  name: (identifier) @field)

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
  name: (identifier) @attribute)

; types

(tinyint) @type.builtin

; keywords

(column_definition
  (keyword_null) @keyword)

(keyword_after) @keyword

(keyword_comment) @keyword

(keyword_modify) @keyword
