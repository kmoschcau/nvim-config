; extends

(razor_using_directive
  name: (identifier) @module)

(qualified_name
  name: (identifier) @module)

(razor_using_directive
  _
  "at_using" @keyword.import)

"@" @punctuation.special

(razor_block
  [
    "{"
    "}"
  ] @punctuation.special)

(razor_section
  [
    "{"
    "}"
  ] @punctuation.special)

(razor_explicit_expression
  (parenthesized_expression
    [
      "("
      ")"
    ] @punctuation.special))

(razor_if
  [
    "{"
    "}"
  ] @punctuation.special)
