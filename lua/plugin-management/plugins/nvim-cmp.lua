local dependencies = {
  "L3MON4D3/cmp-luasnip-choice",
  { "dcampos/cmp-emmet-vim", dependencies = "mattn/emmet-vim" },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-path",
  "jmbuhr/otter.nvim",
  "lukas-reineke/cmp-under-comparator",
  "micangl/cmp-vimtex",
  "onsails/lspkind.nvim",
  { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
  "rcarriga/cmp-dap",
  "saadparwaiz1/cmp_luasnip",
  "windwp/nvim-autopairs",
}

if vim.fn.executable "fish" == 1 then
  table.insert(dependencies, "mtoohey31/cmp-fish")
end

--- @type LazyPluginSpec
return {
  "hrsh7th/nvim-cmp",
  dependencies = dependencies,
  config = function()
    local buffer_source = {
      name = "buffer",
      option = {
        keyword_pattern = [[\k\+]],
      },
    }

    local luasnip = require "luasnip"
    local cmp = require "cmp"
    cmp.setup {
      enabled = function()
        return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
      end,
      preselect = cmp.PreselectMode.None,
      completion = {
        autocomplete = false,
      },
      view = {
        entries = { name = "custom", selection_order = "near_cursor" },
      },
      formatting = {
        format = function(entry, vim_item)
          local symbols = require "symbols"

          local menu_symbol = symbols.cmp_sources[entry.source.name] or "  "
          vim_item.menu = "[" .. menu_symbol .. entry.source.name .. "]"

          if vim.list_contains({ "path" }, entry.source.name) then
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
            symbol_map = symbols.types,
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
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "otter" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        {
          name = "emmet_vim",
          option = {
            "css",
            "html",
            "javascriptreact",
            "jsx",
            "less",
            "razor",
            "sass",
            "scss",
            "svelte",
            "tsx",
            "typescriptreact",
            "vue",
            "xml",
          },
        },
        { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "path" },
      }, {
        buffer_source,
      }),
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

    require("cmp_luasnip_choice").setup {}

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
      },
    })

    if vim.fn.executable "fish" == 1 then
      cmp.setup.filetype("fish", {
        sources = {
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
      sources = cmp.config.sources({
        { name = "git" },
        { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "path" },
      }, {
        buffer_source,
      }),
    })
    require("cmp_git").setup()

    cmp.setup.filetype("tex", {
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "vimtex" },
        { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "path" },
      },
    })

    cmp.setup.cmdline({ "/", "?" }, {
      completion = {
        autocomplete = false,
      },
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        buffer_source,
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
              "Neotree",
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
