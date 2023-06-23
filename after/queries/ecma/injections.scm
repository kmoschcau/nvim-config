;; extends

; el.innerHTML = `<html>`.trim()
(assignment_expression
  left: (member_expression
          property: (property_identifier) @_prop
          (#any-of? @_prop "innerHTML" "outerHTML"))
  right: (call_expression
           function: (member_expression
                       object: (template_string) @html
                       property: (property_identifier) @_prop2
                       (#any-of? @_prop2 "trim")
                       (#offset! @html 0 1 0 -1))))
