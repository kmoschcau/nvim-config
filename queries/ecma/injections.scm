; extends

; el.innerHTML = `<html>`.trim()
(assignment_expression
  left: (member_expression
          property: (property_identifier) @_prop
          (#any-of? @_prop "innerHTML" "outerHTML"))
  right: (call_expression
           function: (member_expression
                       object: (template_string) @injection.content
                       property: (property_identifier) @_prop2
                       (#any-of? @_prop2 "trim")
                       (#offset! @injection.content 0 1 0 -1)
                       (#set! injection.language "html"))))
