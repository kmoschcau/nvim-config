; extends

; GitHub flavored markdown: table box drawing

(pipe_table_header
  "|" @punctuation.special (#set! conceal "│"))

(pipe_table_delimiter_row
  "|" @punctuation.special (#set! conceal "├")
  (pipe_table_delimiter_cell))

(pipe_table_delimiter_row
  (pipe_table_delimiter_cell)
  "|" @punctuation.special (#set! conceal "┤"))

(pipe_table_delimiter_row
  (pipe_table_delimiter_cell)
  "|" @punctuation.special (#set! conceal "┼")
  (pipe_table_delimiter_cell))

(pipe_table_delimiter_cell
  "-" @punctuation.special (#set! conceal "─"))

(pipe_table_row
  "|" @punctuation.special (#set! conceal "│"))
