-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    "luukvbaal/statuscol.nvim",
  },
  config = function()
    local has_statuscol = pcall(require, "statuscol")

    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    local config = {
      signs = {
        ---@diagnostic disable-next-line: missing-fields
        delete = { show_count = true },
        ---@diagnostic disable-next-line: missing-fields
        topdelete = { show_count = true },
        ---@diagnostic disable-next-line: missing-fields
        changedelete = { show_count = true },
      },
      -- This is just so gitsigns are always on the left of the signcolumn.
      sign_priority = has_statuscol and nil or 1000,
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
      numhl = not has_statuscol,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end

          vim.schedule(function()
            gs.nav_hunk "next"
          end)

          return "<Ignore>"
        end, {
          buffer = bufnr,
          desc = "gitsigns: Jump to the next hunk.",
          expr = true,
          silent = true,
        })

        vim.keymap.set("n", "]C", function()
          vim.schedule(function()
            gs.nav_hunk("next", { target = "staged" })
          end)

          return "<Ignore>"
        end, {
          buffer = bufnr,
          desc = "gitsigns: Jump to the next staged hunk.",
          expr = true,
          silent = true,
        })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end

          vim.schedule(function()
            gs.nav_hunk "prev"
          end)

          return "<Ignore>"
        end, {
          buffer = bufnr,
          desc = "gitsigns: Jump to the previous hunk.",
          expr = true,
          silent = true,
        })

        vim.keymap.set("n", "[C", function()
          vim.schedule(function()
            gs.nav_hunk("prev", { target = "staged" })
          end)

          return "<Ignore>"
        end, {
          buffer = bufnr,
          desc = "gitsigns: Jump to the previous staged hunk.",
          expr = true,
          silent = true,
        })

        vim.keymap.set("n", "gsbb", function()
          vim.schedule(gs.blame)

          return "<Ignore>"
        end, {
          buffer = bufnr,
          desc = "gitsigns: Show the blame for the current buffer.",
          expr = true,
          silent = true,
        })

        vim.keymap.set("n", "gsbl", function()
          vim.schedule(gs.blame_line)

          return "<Ignore>"
        end, {
          buffer = bufnr,
          desc = "gitsigns: Show the blame for the current line.",
          expr = true,
          silent = true,
        })

        vim.keymap.set("n", "gsp", gs.preview_hunk, {
          buffer = bufnr,
          desc = "gitsigns: Show a preview of the hunk under the cursor.",
        })
      end,
    }

    require("gitsigns").setup(config)
  end,
}
