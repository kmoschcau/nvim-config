require("gitsigns").setup {
  signs = {
    delete = { show_count = true },
    topdelete = { show_count = true },
    changedelete = { show_count = true },
    untracked = { text = "┇" },
  },
  count_chars = {
    [1] = "₁",
    [2] = "₂",
    [3] = "₃",
    [4] = "₄",
    [5] = "₅",
    [6] = "₆",
    [7] = "₇",
    [8] = "₈",
    [9] = "₉",
    ["+"] = "₊",
  },
  numhl = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end

      vim.schedule(function()
        gs.next_hunk()
      end)

      return "<Ignore>"
    end, {
      buffer = bufnr,
      desc = "Jump to the next (git) diff hunk.",
      expr = true,
      silent = true,
    })

    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end

      vim.schedule(function()
        gs.prev_hunk()
      end)

      return "<Ignore>"
    end, {
      buffer = bufnr,
      desc = "Jump to the previous (git) diff hunk.",
      expr = true,
      silent = true,
    })

    vim.keymap.set("n", "ghp", gs.preview_hunk, {
      buffer = bufnr,
      desc = "Show a preview of the (git) diff hunk under the cursor.",
      silent = true,
    })
  end,
}
