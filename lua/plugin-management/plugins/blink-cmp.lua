local symbols = require "symbols"

--- @param ctx blink.cmp.DrawItemContext
--- @return string, string
local function get_path_component(ctx)
  local full_path = ctx.item.data.full_path
  local icons = require "mini.icons"
  if ctx.kind == "Folder" then
    return icons.get("directory", full_path)
  end

  return icons.get("file", full_path)
end

-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "saghen/blink.cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "folke/lazydev.nvim",
    "rafamadriz/friendly-snippets",
    "rcarriga/cmp-dap",
    { "saghen/blink.compat", lazy = true, config = true },
  },
  build = "cargo build --release",
  init = function()
    vim.keymap.set("i", "<C-x><C-u>", function()
      require("blink.cmp").show()
      require("blink.cmp").show_documentation()
      require("blink.cmp").hide_documentation()
    end)
  end,
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = { window = { border = "rounded" } },
      list = {
        selection = function(ctx)
          return ctx.mode == "cmdline" and "auto_insert" or "preselect"
        end,
      },
      menu = {
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                if ctx.source_id == "path" then
                  local kind_icon = get_path_component(ctx)
                  return kind_icon
                end

                if ctx.kind == "Color" then
                  return ctx.kind_icon
                end

                return symbols.types[ctx.kind]
              end,
              highlight = function(ctx)
                if ctx.source_id == "path" then
                  local _, highlight = get_path_component(ctx)
                  return highlight
                end

                if ctx.kind == "Color" then
                  local color_item = require("nvim-highlight-colors").format(
                    ctx.item.documentation,
                    {
                      kind = ctx.kind,
                    }
                  )

                  if color_item.abbr_hl_group then
                    return color_item.abbr_hl_group
                  end
                end

                return "BlinkCmpKind" .. ctx.kind
              end,
            },
            kind = {
              highlight = function()
                return "None"
              end,
            },
          },
          treesitter = { "lazydev", "lsp" },
        },
      },
    },
    enabled = function()
      return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    keymap = {
      preset = "none",
      ["<C-e>"] = { "cancel", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },
    },
    snippets = {
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      expand = require("luasnip").lsp_expand,
      jump = require("luasnip").jump,
    },
    sources = {
      default = { "lazydev", "dap", "lsp", "path", "snippets", "buffer" },
      providers = {
        dap = {
          name = "dap",
          module = "blink.compat.source",
          score_offset = 90,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}
