-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "mattn/emmet-vim",
  dir = "~/Code/emmet-vim",
  init = function()
    vim.g.emmet_install_only_plug = 1
    vim.g.user_emmet_settings = {
      html = {
        empty_element_suffix = " />",
      },
    }
  end,
  config = function()
    vim.keymap.set("n", "<Space>ea", "<Plug>(emmet-expand-abbr)", {
      desc = "Emmet: Expand abbreviation.",
      silent = true,
    })

    -- This replaces the built-in abbreviation trigger.
    vim.keymap.set("i", "<C-]>", "<Plug>(emmet-expand-abbr)", {
      desc = "Emmet: Expand abbreviation.",
      silent = true,
    })

    vim.keymap.set("x", "<C-]>", "<Plug>(emmet-expand-abbr)", {
      desc = "Emmet: Wrap with abbreviation.",
      silent = true,
    })

    vim.keymap.set("n", "<Space>ew", "<Plug>(emmet-expand-word)", {
      desc = "Emmet: Expand word.",
      silent = true,
    })

    vim.keymap.set("n", "<Space>eu", "<Plug>(emmet-update-tag)", {
      desc = "Emmet: Update tag.",
      silent = true,
    })

    -- This is done better by treesitter incremental selection.
    -- vim.keymap.set(
    --   { "n", "x" },
    --   "<Space>ee",
    --   "<Plug>(emmet-balance-tag-inward)",
    --   {
    --     desc = "Emmet: Expand tag selection.",
    --     silent = true,
    --   }
    -- )

    -- This is done better by treesitter incremental selection.
    -- vim.keymap.set(
    --   { "n", "x" },
    --   "<Space>es",
    --   "<Plug>(emmet-balance-tag-outword)", -- (sic)
    --   {
    --     desc = "Emment: Shrink/advance tag selection.",
    --     silent = true,
    --   }
    -- )

    vim.keymap.set("n", "<Space>en", "<Plug>(emmet-move-next)", {
      desc = "Emmet: Go to next edit point.",
      silent = true,
    })

    vim.keymap.set("i", "<C-G>n", "<Plug>(emmet-move-next)", {
      desc = "Emmet: Go to next edit point.",
      silent = true,
    })

    vim.keymap.set("n", "<Space>ep", "<Plug>(emmet-move-prev)", {
      desc = "Emmet: Go to previous edit point.",
      silent = true,
    })

    -- This does not seem to work.
    -- vim.keymap.set("i", "<C-G>p", "<Plug>(emmet-move-prev)", {
    --   desc = "Emmet: Go to previous edit point.",
    --   silent = true,
    -- })

    vim.keymap.set("n", "<Space>eis", "<Plug>(emmet-image-size)", {
      desc = "Emmet: Add/update <img> size.",
      silent = true,
    })

    vim.keymap.set("n", "<Space>eie", "<Plug>(emmet-image-encode)", {
      desc = "Emmet: base64-encode <img> from src.",
      silent = true,
    })

    -- This one seems not to work.
    -- vim.keymap.set("n", "<C-y>m", "<Plug>(emmet-merge-lines)", {
    --   desc = "Emmet: Merge lines",
    --   silent = true,
    -- })

    -- This one is already done better by the `dat` keymap.
    -- vim.keymap.set("n", "<C-y>k", "<Plug>(emmet-remove-tag)", {
    --   desc = "Emmet: Remove tag",
    --   silent = true,
    -- })

    vim.keymap.set("n", "<Space>em", "<Plug>(emmet-split-join-tag)", {
      desc = "Emmet: Split/join tag.",
      silent = true,
    })

    vim.keymap.set("n", "<Space>ec", "<Plug>(emmet-toggle-comment)", {
      desc = "Emmet: Toggle comment.",
      silent = true,
    })

    vim.keymap.set("n", "<Space>ema", "<Plug>(emmet-anchorize-url)", {
      desc = "Emmet: Make anchor from URL.",
      silent = true,
    })

    vim.keymap.set("n", "<Space>ems", "<Plug>(emmet-anchorize-summary)", {
      desc = "Emmet: Make quoted text from URL.",
      silent = true,
    })

    -- This is done better by :TOhtml.
    -- vim.keymap.set("x", "<C-y>c", "<Plug>(emmet-code-pretty)", {
    --   desc = "Emmet: Code pretty",
    --   silent = true,
    -- })
  end,
}
