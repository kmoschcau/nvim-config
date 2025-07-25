-- cspell:words dapui lazydev luasnip vimtex

local symbols = require "symbols"

local buffer_source_include_buffer_types = { "", "help" }

---@type table<integer, boolean?>
local spell_enabled_cache = {}

vim.api.nvim_create_autocmd("OptionSet", {
  group = vim.api.nvim_create_augroup("blink_cmp_spell", {}),
  desc = "Reset the cache for enabling the spell source for blink.cmp.",
  pattern = "spelllang",
  callback = function()
    spell_enabled_cache[vim.fn.bufnr()] = nil
  end,
})

---Test whether a given buffer should be included for the buffer completion
---source.
---@param bufnr integer the number of the buffer to check
---@return boolean include whether to include the buffer for completion
local function buffer_source_should_include_buffer(bufnr)
  return vim.list_contains(
    buffer_source_include_buffer_types,
    vim.bo[bufnr].buftype
  )
end

---Get the buffer numbers for the buffer completion source.
---@return integer[] bufnrs the buffer numbers
local function get_buffers_for_buffer_source()
  return vim.tbl_filter(
    buffer_source_should_include_buffer,
    vim.api.nvim_list_bufs()
  )
end

---This is a transform to preserve the capitalization of the keyword to
---complete in the suggested completion items.
---@param context blink.cmp.Context the blink context
---@param items blink.cmp.CompletionItem[] the completion items
---@return blink.cmp.CompletionItem[]? items the adjusted completion items
local function capitalization_preserving_transform(context, items)
  local keyword = context.get_keyword()

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

---Get the icon string and highlight for a file path.
---@param context blink.cmp.DrawItemContext the blink context
---@return string icon the icon string
---@return string highlight the highlight group name
local function get_path_component(context)
  local full_path = context.item.data.full_path
  local icons = require "mini.icons"
  if context.kind == "Folder" then
    return icons.get("directory", full_path)
  end

  return icons.get("file", full_path)
end

---Get the kind icon for a specific completion item.
---@param context blink.cmp.DrawItemContext the blink context
---@return string icon_text the icon string
local function kind_icon_text(context)
  if context.source_id == "path" then
    local kind_icon, _ = get_path_component(context)
    return kind_icon
  end

  if context.kind == "Color" then
    return context.kind_icon
  end

  return symbols.types[context.kind]
end

---Get the highlight group name for a specific completion item.
---@param context blink.cmp.DrawItemContext the blink context
---@return string highlight the highlight group name
local function kind_icon_highlight(context)
  if context.source_id == "path" then
    local _, highlight = get_path_component(context)
    return highlight
  end

  if context.kind == "Color" then
    local color_item =
      require("nvim-highlight-colors").format(context.item.documentation, {
        kind = context.kind,
      })

    if color_item.abbr_hl_group then
      return color_item.abbr_hl_group
    end
  end

  return "BlinkCmpKind" .. context.kind
end

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "saghen/blink.cmp",
  dependencies = {
    -- cspell:disable
    "L3MON4D3/LuaSnip",
    "echasnovski/mini.nvim",
    "folke/lazydev.nvim",
    "micangl/cmp-vimtex",
    "moyiz/blink-emoji.nvim",
    "mtoohey31/cmp-fish",
    "rafamadriz/friendly-snippets",
    "rcarriga/cmp-dap",
    "ribru17/blink-cmp-spell",
    { "saghen/blink.compat", lazy = true, config = true },
    "xzbdmw/colorful-menu.nvim",
    -- cspell:enable
  },
  build = "cargo build --release",
  init = function()
    vim.keymap.set("i", "<C-x><C-u>", function()
      require("blink.cmp").show()
      require("blink.cmp").show_documentation()
      require("blink.cmp").hide_documentation()
    end, {
      desc = "blink.cmp: Trigger completion.",
    })

    vim.keymap.set("i", "<Down>", function()
      if require("blink.cmp").select_next { auto_insert = false } then
        return "<Ignore>"
      end

      return "<Down>"
    end, {
      desc = "blink.cmp: Select next completion item without inserting.",
      expr = true,
      silent = true,
    })

    vim.keymap.set("i", "<Up>", function()
      if require("blink.cmp").select_prev { auto_insert = false } then
        return "<Ignore>"
      end

      return "<Up>"
    end, {
      desc = "blink.cmp: Select next completion item without inserting.",
      expr = true,
      silent = true,
    })
  end,
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = {
        auto_show = true,
      },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
          components = {
            label = {
              text = function(context)
                return require("colorful-menu").blink_components_text(context)
              end,
              highlight = function(context)
                return require("colorful-menu").blink_components_highlight(
                  context
                )
              end,
            },
            kind_icon = {
              ellipsis = false,
              text = kind_icon_text,
              highlight = kind_icon_highlight,
            },
            source_name = {
              highlight = "None",
            },
          },
          treesitter = { "lazydev", "lsp" },
        },
      },
    },
    fuzzy = {
      sorts = {
        function(a, b)
          local sort = require "blink.cmp.fuzzy.sort"
          if a.source_id == "spell" and b.source_id == "spell" then
            return sort.label(a, b)
          end
        end,
        "score",
        "sort_text",
      },
    },
    keymap = {
      preset = "none",
      ["<C-e>"] = { "cancel", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = false,
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "emoji", "spell", "buffer" },
      per_filetype = {
        ["dap-repl"] = { "dap" },
        ["dapui_hover"] = { "dap" },
        ["dapui_watches"] = { "dap" },
        lua = { inherit_defaults = true, "lazydev" },
        fish = { inherit_defaults = true, "fish" },
        tex = { inherit_defaults = true, "vimtex" },
      },
      providers = {
        buffer = {
          opts = {
            get_bufnrs = get_buffers_for_buffer_source,
          },
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
        spell = {
          module = "blink-cmp-spell",
          name = "Spell",
          enabled = function()
            local bufnr = vim.fn.bufnr()
            local enabled = spell_enabled_cache[bufnr]
            if type(enabled) ~= "boolean" then
              enabled =
                not vim.list_contains(vim.opt_local.spelllang:get(), "de")
              spell_enabled_cache[bufnr] = enabled
            end
            return enabled
          end,
          opts = {
            enable_in_context = function()
              local cursor = vim.api.nvim_win_get_cursor(0)
              local captures = vim.treesitter.get_captures_at_pos(
                0,
                cursor[1] - 1,
                cursor[2] - 1
              )
              local in_spell_capture = false
              for _, capture in ipairs(captures) do
                if capture.capture == "spell" then
                  in_spell_capture = true
                elseif capture.capture == "nospell" then
                  return false
                end
              end
              return in_spell_capture
            end,
          },
        },
        vimtex = {
          module = "blink.compat.source",
          name = "vimtex",
        },
      },
    },
  },
}
