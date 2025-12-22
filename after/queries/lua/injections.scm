; extends
; ---@…
(comment
  start: "--"
  content: (comment_content) @injection.content
  (#match? @injection.content "^-\\@")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "luadoc"))
