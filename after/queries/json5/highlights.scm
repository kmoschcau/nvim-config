; extends

; this is just to "remove" the bold highlight of the default query
(member
  name: (_) @reset.bold)

(null) @constant.builtin

(object
  [
    "{"
    "}"
  ] @punctuation.bracket)

(object
  "," @punctuation.delimiter)

(member
  name: (_) @property)

(member
  ":" @punctuation.delimiter)
