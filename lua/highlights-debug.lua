return {
  --- Get a highlight from the current semantic highlights of the buffer.
  --- This should only be called on buffers where semantic tokens highlighting
  --- is already started.
  --- @param bufnr number number of the buffer to search in
  --- @return table|nil highlight a highlight table, or nil when none is found
  get_semantic_highlight = function(bufnr)
    local highlights =
      vim.lsp.semantic_tokens.__STHighlighter.active[bufnr].client_state[1].current_result.highlights
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))

    for _, highlight in ipairs(highlights) do
      if highlight.line > line then
        return nil
      end

      if
        highlight.line == line - 1
        and highlight.start_col <= col
        and highlight.end_col > col
      then
        return highlight
      end
    end
  end,

  --- Show either the built-in regex or Tree-Sitter highlight for the cursor
  --- position.
  --- @return nil
  show_regex_or_ts_highlight = function()
    if not (vim.fn.exists "*synstack" > 0) then
      return
    end

    if vim.fn.exists ":TSHighlightCapturesUnderCursor" > 0 then
      vim.cmd [[TSHighlightCapturesUnderCursor]]
      return
    end

    local line = vim.fn.line "."
    local col = vim.fn.col "."
    local names = {}
    for _, id in ipairs(vim.fn.synstack(line, col)) do
      table.insert(names, vim.fn.synIDattr(id, "name"))
    end
    vim.lsp.util.open_floating_preview(
      vim.split(vim.inspect(names), "\n"),
      "lua",
      { border = "rounded" }
    )
  end
}
