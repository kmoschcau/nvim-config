return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
    { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
    "rcarriga/cmp-dap",
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
  },
  config = function()
    local list_contains = vim.list_contains or vim.tbl_contains

    local buffer_source = {
      name = "buffer",
      option = {
        keyword_pattern = [[\k\+]],
      },
    }

    local luasnip = require "luasnip"
    local cmp = require "cmp"
    local types = require "cmp.types"
    cmp.setup {
      enabled = function()
        return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
      end,
      view = {
        entries = { name = "custom", selection_order = "near_cursor" },
      },
      formatting = {
        format = function(entry, vim_item)
          if list_contains({ "path" }, entry.source.name) then
            local icon, hl_group = require("nvim-web-devicons").get_icon(
              entry:get_completion_item().label
            )
            if icon then
              vim_item.kind = icon
              vim_item.kind_hl_group = hl_group
              return vim_item
            end
          end
          return require("lspkind").cmp_format {
            mode = "symbol_text",
            symbol_map = require("icons").types,
          }(entry, vim_item)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-l>"] = cmp.mapping.complete_common_string(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
      }, {
        buffer_source,
      }),
    }

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
        { name = "luasnip" },
      }, {
        buffer_source,
      }),
    })
    require("cmp_git").setup()

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
      },
    })

    cmp.setup.cmdline({ "/", "?" }, {
      completion = {
        autocomplete = {
          types.cmp.TriggerEvent.TextChanged,
        },
      },
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        buffer_source,
      },
    })

    cmp.setup.cmdline(":", {
      completion = {
        autocomplete = {
          types.cmp.TriggerEvent.TextChanged,
        },
      },
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
