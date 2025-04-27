-- selene: allow(mixed_table)
local dependencies = {
  "L3MON4D3/LuaSnip",
  "L3MON4D3/cmp-luasnip-choice",
  "MeanderingProgrammer/render-markdown.nvim",
  "echasnovski/mini.nvim",
  "folke/lazydev.nvim",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-path",
  "lukas-reineke/cmp-under-comparator",
  "micangl/cmp-vimtex",
  { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
  "rcarriga/cmp-dap",
  "saadparwaiz1/cmp_luasnip",
  "windwp/nvim-autopairs",
}

if vim.fn.executable "fish" == 1 then
  table.insert(dependencies, "mtoohey31/cmp-fish")
end

-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "hrsh7th/nvim-cmp",
  enabled = false,
  dependencies = dependencies,
  config = function()
    local luasnip = require "luasnip"
    local cmp = require "cmp"
    cmp.setup {
      enabled = function()
        return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
      end,
      view = {
        entries = { name = "custom", selection_order = "near_cursor" },
      },
      formatting = {
        format = function(entry, vim_item)
          local symbols = require "symbols"

          local return_item = vim.tbl_extend("force", {}, vim_item)

          return_item.menu = string.format(
            "[%s%s]",
            symbols.cmp_sources[entry.source.name] or "  ",
            entry.source.name
          )

          if vim.list_contains({ "path" }, entry.source.name) then
            local icon, hl_group =
              require("mini.icons").get("file", entry.completion_item().label)

            if icon then
              return_item.kind = icon
              return_item.kind_hl_group = hl_group
              return return_item
            end
          end

          return_item.kind =
            string.format("%s%s", symbols.types[vim_item.kind], vim_item.kind)

          if vim_item.kind == "Color" then
            local color_item = require("nvim-highlight-colors").format(
              entry,
              vim.tbl_extend("force", {}, vim_item)
            )
            if color_item.abbr_hl_group then
              return_item.kind_hl_group = color_item.abbr_hl_group
            end
          end

          return return_item
        end,
      },
      mapping = {
        ["<C-x><C-u>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-n>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
          else
            fallback()
          end
        end,
        ["<C-p>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
          else
            fallback()
          end
        end,
        ["<Down>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          else
            fallback()
          end
        end,
        ["<Up>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
          else
            fallback()
          end
        end,
        ["<C-l>"] = cmp.mapping.complete_common_string(),
        ["<C-y>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "path" },
      },
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require("cmp-under-comparator").under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    }

    require("cmp_luasnip_choice").setup {
      auto_open = false,
    }

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
      },
    })

    if vim.fn.executable "fish" == 1 then
      cmp.setup.filetype("fish", {
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "fish" },
          { name = "luasnip" },
          { name = "luasnip_choice" },
          { name = "path" },
        },
      })
    end

    cmp.setup.filetype("gitcommit", {
      completion = {
        autocomplete = false,
      },
      sources = cmp.config.sources {
        { name = "git" },
        { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "path" },
      },
    })
    require("cmp_git").setup()

    cmp.setup.filetype("lua", {
      sources = cmp.config.sources {
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "path" },
      },
    })

    cmp.setup.filetype("markdown", {
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "render-markdown" },
        { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "path" },
      },
    })

    cmp.setup.filetype("tex", {
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "vimtex" },
        { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "path" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = {
              "!",
              "Man",
              "terminal",
            },
          },
        },
      }),
    })

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
