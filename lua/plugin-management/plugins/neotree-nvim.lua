local icons = require "icons"

local function map_kinds()
  local ret_val = {}

  for key, value in pairs(icons.types) do
    ret_val[key] = { icon = value }
  end

  return ret_val
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
      git_status = {
        symbols = vim.tbl_extend("error", icons.git.lines, icons.git.files),
      },
    },
    nesting_rules = {
      razor = { "razor.cs", "razor.css" },
    },
    window = {
      mappings = {
        ["<space>"] = { "toggle_node", nowait = true },
        ["<cr>"] = "open_with_window_picker",
        S = "none",
        ["<C-s>"] = "split_with_window_picker",
        s = "none",
        ["<C-v>"] = "vsplit_with_window_picker",
        t = "none",
        ["<C-t>"] = "open_tabnew",
        ["[g"] = "none",
        ["]g"] = "none",
        w = "none",
      },
    },
    filesystem = {
      group_empty_dirs = true,
      hijack_netrw_behavior = "open_current",
      window = {
        mappings = {
          ["[c"] = "prev_git_modified",
          ["]c"] = "next_git_modified",
        },
      },
    },
    document_symbols = {
      kinds = map_kinds(),
    },
  },
}

-- TODO:
-- - remove toggle notification for hidden files
