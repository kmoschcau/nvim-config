local icons = require "icons"

local function map_kinds()
  local ret_val = {}

  for key, value in pairs(icons.types) do
    ret_val[key] = { icon = value }
  end

  return ret_val
end

local function index_of(array, value)
  for i, v in ipairs(array) do
    if v == value then
      return i
    end
  end
  return nil
end

local function get_siblings(state, node)
  local parent = state.tree:get_node(node:get_parent_id())
  local siblings = parent:get_child_ids()
  return siblings
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      opts = {
        autoselect_one = true,
        include_current = true,
        filter_rules = {
          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" },
          },
        },
      },
    },
  },
  keys = {
    {
      "<C-n>",
      ":Neotree toggle=true<cr>",
      desc = "Toggle the neo-tree window.",
      silent = true,
    },
  },
  opts = {
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    enable_normal_mode_for_inputs = true,
    popup_border_style = "rounded",
    default_component_configs = {
      name = {
        trailing_slash = true,
        highlight_opened_files = true,
      },
      modified = {
        symbol = icons.files.modified,
      },
      git_status = {
        symbols = vim.tbl_extend("error", icons.git.lines, icons.git.files),
      },
    },
    nesting_rules = {
      cshtml = { "cshtml.cs" },
      razor = { "razor.cs", "razor.css" },
      xaml = { "xaml.cs" },
    },
    window = {
      mappings = {
        ["<C-j>"] = function(state)
          local node = state.tree:get_node()
          local siblings = get_siblings(state, node)
          if not node.is_last_child then
            local current_index = index_of(siblings, node.id)
            local next_index = siblings[current_index + 1]
            require("neo-tree.ui.renderer").focus_node(state, next_index)
          end
        end,
        ["<C-k>"] = function(state)
          local node = state.tree:get_node()
          local siblings = get_siblings(state, node)
          local current_index = index_of(siblings, node.id)
          if current_index > 1 then
            local previous_index = siblings[current_index - 1]
            require("neo-tree.ui.renderer").focus_node(state, previous_index)
          end
        end,
        ["<C-s>"] = "split_with_window_picker",
        ["<C-t>"] = "open_tabnew",
        ["<C-v>"] = "vsplit_with_window_picker",
        ["<cr>"] = "open",
        ["<space>"] = { "toggle_node", nowait = true },
        ["[g"] = "none",
        ["]g"] = "none",
        J = function(state)
          local node = state.tree:get_node()
          local siblings = get_siblings(state, node)
          require("neo-tree.ui.renderer").focus_node(state, siblings[#siblings])
        end,
        K = function(state)
          local node = state.tree:get_node()
          local siblings = get_siblings(state, node)
          require("neo-tree.ui.renderer").focus_node(state, siblings[1])
        end,
        S = "none",
        o = "open_with_window_picker",
        oc = "none",
        od = "none",
        og = "none",
        om = "none",
        on = "none",
        os = "none",
        ot = "none",
        s = "none",
        t = "none",
        w = "none",
      },
    },
    filesystem = {
      group_empty_dirs = true,
      hijack_netrw_behavior = "open_current",
      commands = {
        toggle_hidden = function(state)
          -- might break in the future, as we are using internals
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/sources/filesystem/commands.lua#L230C8
          state.filtered_items.visible = not state.filtered_items.visible
          require("neo-tree.sources.filesystem")._navigate_internal(
            state,
            nil,
            nil,
            nil,
            false
          )
        end,
      },
      window = {
        mappings = {
          ["[c"] = "prev_git_modified",
          ["]c"] = "next_git_modified",
          sc = "order_by_created",
          sd = "order_by_diagnostics",
          sg = "order_by_git_status",
          sm = "order_by_modified",
          sn = "order_by_name",
          ss = "order_by_size",
          st = "order_by_type",
        },
      },
    },
    buffers = {
      window = {
        mappings = {
          sc = "order_by_created",
          sd = "order_by_diagnostics",
          sm = "order_by_modified",
          sn = "order_by_name",
          ss = "order_by_size",
          st = "order_by_type",
        },
      },
    },
    git_status = {
      window = {
        mappings = {
          sc = "order_by_created",
          sd = "order_by_diagnostics",
          sm = "order_by_modified",
          sn = "order_by_name",
          ss = "order_by_size",
          st = "order_by_type",
        },
      },
    },
    document_symbols = {
      kinds = map_kinds(),
    },
  },
}
