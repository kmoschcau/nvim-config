; extends

; el.innerHTML = `<html>`.trim()
(assignment_expression
  left: (member_expression
    property: (property_identifier) @_prop
    (#any-of? @_prop "outerHTML" "innerHTML"))
  right: (call_expression
    function: (member_expression
      object: (template_string) @injection.content
      property: (property_identifier) @_prop2
      (#any-of? @_prop2 "trim")
      (#offset! @injection.content 0 1 0 -1)
      (#set! injection.include-children)
      (#set! injection.language "html"))))

; el.insertAdjacentHTML("…", `<html>`)
(call_expression
  function: (member_expression
    property: (property_identifier) @_prop
    (#match? @_prop "insertAdjacentHTML"))
  arguments: (arguments
    (template_string) @injection.content)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "html"))

; el.insertAdjacentHTML("…", "<html>")
(call_expression
  function: (member_expression
    property: (property_identifier) @_prop
    (#match? @_prop "insertAdjacentHTML"))
  arguments: (arguments
    (string
      (string_fragment) @injection.content) .)
  (#set! injection.language "html"))
