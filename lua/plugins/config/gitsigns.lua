require("gitsigns").setup {
  signs = {
    add = {
      hl = "Material_VimDiffSignAdd",
      numhl = "Material_VimDiffSignAdd",
      linehl = "Material_VimDiffLineAdd",
    },
    change = {
      hl = "Material_VimDiffSignChange",
      numhl = "Material_VimDiffSignChange",
      linehl = "Material_VimDiffLineChange",
    },
    delete = {
      hl = "Material_VimDiffSignDelete",
      numhl = "Material_VimDiffSignDelete",
      linehl = "Material_VimDiffLineDelete",
    },
    topdelete = {
      hl = "Material_VimDiffSignDelete",
      numhl = "Material_VimDiffSignDelete",
      linehl = "Material_VimDiffLineDelete",
    },
    changedelete = {
      hl = "Material_VimDiffSignChangeDelete",
      numhl = "Material_VimDiffSignChangeDelete",
      linehl = "Material_VimDiffLineChangeDelete",
    },
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
  end,
}
