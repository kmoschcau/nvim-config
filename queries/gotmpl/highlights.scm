; Identifiers

([
  (field)
  (field_identifier)
  ] @property (#set! priority 101))

((variable) @variable (#set! priority 101))

; Function calls

(function_call
  function: (identifier) @function (#set! priority 101))

(method_call
  method: (selector_expression
            field: (field_identifier) @method (#set! priority 101)))

; Operators

([
  "|"
  ":="
  ] @operator (#set! priority 101))

; Builtin functions

((identifier) @function.builtin
              (#set! priority 101)
              (#match? @function.builtin "^(and|call|html|index|slice|js|len|not|or|print|printf|println|urlquery|eq|ne|lt|ge|gt|ge)$"))

; Delimiters

([
  "."
  ","
  ] @punctuation.delimiter (#set! priority 101))

([
  "{{"
  "}}"
  "{{-"
  "-}}"
  ")"
  "("
  "{{"
  ] @punctuation.bracket (#set! priority 101))

; Keywords

([
  "else"
  "if"
  ] @conditional (#set! priority 101))

([
  "range"
  "with"
  "end"
  "template"
  "define"
  "block"
  ] @keyword (#set! priority 101))

; Literals

([
  (interpreted_string_literal)
  (raw_string_literal)
  (rune_literal)
  ] @string (#set! priority 101))

((escape_sequence) @string.special (#set! priority 101))

([
  (int_literal)
  (float_literal)
  (imaginary_literal)
  ] @number (#set! priority 101))

([
  (true)
  (false)
  ] @boolean (#set! priority 101))

([
  (nil)
  ] @constant.builtin (#set! priority 101))

((comment) @comment (#set! priority 101))
((ERROR) @error (#set! priority 101))
