--- @type LazyPluginSpec
return {
  "mattn/emmet-vim",
  init = function()
    vim.g.emmet_install_only_plug = 1
    vim.g.user_emmet_settings = {
      html = {
        empty_element_suffix = " />",
      },
    }
  end,
  config = function()
    vim.keymap.set("n", "<space>ea", "<Plug>(emmet-expand-abbr)", {
      desc = "Emmet: Expand abbreviation.",
      silent = true,
    })

    -- This replaces the built-in abbreviation trigger, but I don't use
    -- abbreviations anyway.
    vim.keymap.set("i", "<C-]>", "<Plug>(emmet-expand-abbr)", {
      desc = "Emmet: Expand abbreviation.",
      silent = true,
    })

    vim.keymap.set("x", "<C-]>", "<Plug>(emmet-expand-abbr)", {
      desc = "Emmet: Wrap with abbreviation.",
      silent = true,
    })

    vim.keymap.set("n", "<space>ew", "<Plug>(emmet-expand-word)", {
      desc = "Emmet: Expand word.",
      silent = true,
    })

    vim.keymap.set("n", "<space>eu", "<Plug>(emmet-update-tag)", {
      desc = "Emmet: Update tag.",
      silent = true,
    })

    vim.keymap.set(
      { "n", "x" },
      "<space>ee",
      "<Plug>(emmet-balance-tag-inward)",
      {
        desc = "Emmet: Expand tag selection.",
        silent = true,
      }
    )

    vim.keymap.set(
      { "n", "x" },
      "<space>es",
      "<Plug>(emmet-balance-tag-outword)", -- (sic)
      {
        desc = "Emment: Shrink/advance tag selection.",
        silent = true,
      }
    )

    vim.keymap.set("n", "<space>en", "<Plug>(emmet-move-next)", {
      desc = "Emmet: Go to next edit point.",
      silent = true,
    })

    vim.keymap.set("i", "<C-G>n", "<Plug>(emmet-move-next)", {
      desc = "Emmet: Go to next edit point.",
      silent = true,
    })

    vim.keymap.set("n", "<space>ep", "<Plug>(emmet-move-prev)", {
      desc = "Emmet: Go to previous edit point.",
      silent = true,
    })

    -- This does not seem to work.
    -- vim.keymap.set("i", "<C-G>p", "<Plug>(emmet-move-prev)", {
    --   desc = "Emmet: Go to previous edit point.",
    --   silent = true,
    -- })

    vim.keymap.set("n", "<space>eis", "<Plug>(emmet-image-size)", {
      desc = "Emmet: Add/update <img> size.",
      silent = true,
    })

    vim.keymap.set("n", "<space>eie", "<Plug>(emmet-image-encode)", {
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

    vim.keymap.set("n", "<space>em", "<Plug>(emmet-split-join-tag)", {
      desc = "Emmet: Split/join tag.",
      silent = true,
    })

    vim.keymap.set("n", "<space>ec", "<Plug>(emmet-toggle-comment)", {
      desc = "Emmet: Toggle comment.",
      silent = true,
    })

    vim.keymap.set("n", "<space>ema", "<Plug>(emmet-anchorize-url)", {
      desc = "Emmet: Make anchor from URL.",
      silent = true,
    })

    vim.keymap.set("n", "<space>ems", "<Plug>(emmet-anchorize-summary)", {
      desc = "Emmet: Make quoted text from URL.",
      silent = true,
    })

    -- This doesn't work, because :TOhtml doesn't support treesitter.
    -- vim.keymap.set("x", "<C-y>c", "<Plug>(emmet-code-pretty)", {
    --   desc = "Emmet: Code pretty",
    --   silent = true,
    -- })
  end,
}
