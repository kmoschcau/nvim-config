local symbols = require "symbols"

local default_sources =
  { "lsp", "path", "luasnip", "luasnip_choice", "emoji", "buffer" }

--- This is a transform to preserve the capitalization of the keyword to
--- complete in the suggested completion items.
--- @param ctx blink.cmp.Context the blink context
--- @param items blink.cmp.CompletionItem[] the completion items
--- @return blink.cmp.CompletionItem[]? items the adjusted completion items
local function capitalization_preserving_transform(ctx, items)
  local keyword = ctx.get_keyword()
  local other_case_pattern, case_corrector
  if keyword:match "^%l" then
    other_case_pattern = "^%u%l+$"
    case_corrector = string.lower
  elseif keyword:match "^%u" then
    other_case_pattern = "^%l+$"
    case_corrector = string.upper
  else
    return items
  end

  local seen_texts = {}
  local corrected_texts = {}
  for _, item in ipairs(items) do
    local raw = item.insertText
    if type(raw) == "string" and raw:match(other_case_pattern) then
      local text = case_corrector(raw:sub(1, 1)) .. raw:sub(2)
      item.insertText = text
      item.label = text
    end

    if not seen_texts[item.insertText] then
      seen_texts[item.insertText] = true
      table.insert(corrected_texts, item)
    end
  end

  return corrected_texts
end

--- Get the icon string and highlight for a file path.
--- @param ctx blink.cmp.DrawItemContext the blink context
--- @return string icon the icon string
--- @return string highlight the highlight group name
local function get_path_component(ctx)
  local full_path = ctx.item.data.full_path
  local icons = require "mini.icons"
  if ctx.kind == "Folder" then
    return icons.get("directory", full_path)
  end

  return icons.get("file", full_path)
end

--- Get the kind icon for a specific completion item.
--- @param ctx blink.cmp.DrawItemContext the blink context
--- @return string icon_text the icon string
local function kind_icon_text(ctx)
  if ctx.source_id == "path" then
    local kind_icon = get_path_component(ctx)
    return kind_icon
  end

  if ctx.kind == "Color" then
    return ctx.kind_icon
  end

  return symbols.types[ctx.kind]
end

--- Get the highlight group name for a specific completion item.
--- @param ctx blink.cmp.DrawItemContext the blink context
--- @return string highlight the highlight group name
local function kind_icon_highlight(ctx)
  if ctx.source_id == "path" then
    local _, highlight = get_path_component(ctx)
    return highlight
  end

  if ctx.kind == "Color" then
    local color_item =
      require("nvim-highlight-colors").format(ctx.item.documentation, {
        kind = ctx.kind,
      })

    if color_item.abbr_hl_group then
      return color_item.abbr_hl_group
    end
  end

  return "BlinkCmpKind" .. ctx.kind
end

-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "saghen/blink.cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "L3MON4D3/cmp-luasnip-choice",
    "MeanderingProgrammer/render-markdown.nvim",
    "echasnovski/mini.nvim",
    "folke/lazydev.nvim",
    "micangl/cmp-vimtex",
    "moyiz/blink-emoji.nvim",
    "mtoohey31/cmp-fish",
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
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline"
            or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = kind_icon_text,
              highlight = kind_icon_highlight,
            },
            kind = {
              highlight = "None",
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
      cmdline = {
        preset = "none",
        ["<Tab>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-y>"] = { "accept", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
      },
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
      default = default_sources,
      per_filetype = {
        ["dap-repl"] = { "dap" },
        ["dapui_hover"] = { "dap" },
        ["dapui_watches"] = { "dap" },
        lua = vim.list_extend({ "lazydev" }, default_sources),
        markdown = vim.list_extend({ "markdown" }, default_sources),
        fish = vim.list_extend({ "fish" }, default_sources),
        tex = vim.list_extend({ "vimtex" }, default_sources),
      },
      providers = {
        buffer = {
          transform_items = capitalization_preserving_transform,
        },
        dap = {
          module = "blink.compat.source",
          name = "dap",
        },
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
        },
        fish = {
          module = "blink.compat.source",
          name = "fish",
        },
        lazydev = {
          module = "lazydev.integrations.blink",
          name = "LazyDev",
        },
        luasnip_choice = {
          module = "blink.compat.source",
          name = "luasnip_choice",
        },
        markdown = {
          module = "render-markdown.integ.blink",
          name = "RenderMarkdown",
        },
        vimtex = {
          module = "blink.compat.source",
          name = "vimtex",
        },
      },
    },
  },
}
