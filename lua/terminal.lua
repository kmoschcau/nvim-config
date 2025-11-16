local augroup = vim.api.nvim_create_augroup("InitNvimTerminal", {})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Adjust settings to make more sense in a terminal.",
  group = augroup,
  callback = function()
    vim.opt_local.colorcolumn = { "" }
    vim.opt_local.signcolumn = "yes:2"
    vim.opt_local.spell = false
  end,
})

-- TODO: Clear these namespaces on refresh. Maybe clear them, when a new
-- TermRequest is received for a line higher up than the last line.

local term_prompt_ns = vim.api.nvim_create_namespace "TermPromptMarkers"
local term_error_ns = vim.api.nvim_create_namespace "TermErrorDiagnostics"

vim.api.nvim_create_autocmd("TermRequest", {
  desc = "Add extmarks for OSC 133;A requests.",
  group = augroup,
  ---@param args TermRequestArgs
  callback = function(args)
    if not string.match(args.data.sequence, "^\027]133;A") then
      return
    end

    local row = args.data.cursor[1] - 1
    local col = 0
    local row_col = { row, col }

    local existing_marks = vim.api.nvim_buf_get_extmarks(
      args.buf,
      term_prompt_ns,
      row_col,
      row_col,
      {}
    )
    for _, existing_mark in ipairs(existing_marks) do
      vim.api.nvim_buf_del_extmark(args.buf, term_prompt_ns, existing_mark[1])
    end

    vim.api.nvim_buf_set_extmark(args.buf, term_prompt_ns, row, col, {
      sign_hl_group = "@punctuation.special",
      sign_text = require("kmo.symbols").signs.term_prompt,
    })
  end,
})

vim.api.nvim_create_autocmd("TermRequest", {
  desc = "Add diagnostics for OSC 133;D requests with error exit codes.",
  group = augroup,
  ---@param args TermRequestArgs
  callback = function(args)
    if not string.match(args.data.sequence, "^\027]133;D") then
      return
    end

    -- See: https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md#commands

    ---@type string?
    local exit_code = string.match(args.data.sequence, "^\027]133;D;(%d+)")

    ---@type string?
    local err_message =
      string.match(args.data.sequence, "^\027]133;D;%d+;err=(.+)")

    if
      (not exit_code or exit_code == "0")
      and (not err_message or err_message == "")
    then
      return
    end

    local row = args.data.cursor[1] - 1
    local col = args.data.cursor[2]

    local diagnostics =
      vim.diagnostic.get(args.buf, { namespace = term_error_ns })

    ---@type vim.Diagnostic
    local diagnostic = {
      bufnr = args.buf,
      lnum = row,
      end_lnum = row,
      col = col,
      end_col = col,
      severity = vim.diagnostic.severity.ERROR,
      message = err_message or exit_code or "",
      source = "exit-code",
      code = exit_code,
    }
    table.insert(diagnostics, diagnostic)

    vim.diagnostic.set(term_error_ns, args.buf, diagnostics)
  end,
})
