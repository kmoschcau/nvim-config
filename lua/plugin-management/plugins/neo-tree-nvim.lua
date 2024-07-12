local symbols = require "symbols"

local function map_kinds()
  local ret_val = {}

  for key, value in pairs(symbols.types) do
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

--- @type LazyPluginSpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.nvim",
    "nvim-lua/plenary.nvim",
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
      "<Cmd>Neotree toggle=true<CR>",
      desc = "neo-tree: Toggle the window.",
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
    popup_border_style = "rounded",
    default_component_configs = {
      name = {
        trailing_slash = true,
        highlight_opened_files = true,
      },
      modified = {
        symbol = symbols.files.modified,
      },
      git_status = {
        symbols = vim.tbl_extend("error", symbols.git.lines, symbols.git.files),
      },
    },
    nesting_rules = {
      [".NET config"] = {
        pattern = "^(.*)%.config$",
        files = {
          "%1.*.config",
        },
      },
      [".NET appsettings.json"] = {
        pattern = "^appsettings%.json$",
        files = {
          "appsettings.*.json",
        },
      },
      ["Angular components"] = {
        pattern = "^(.*)%.component%.ts$",
        files = {
          "%1.component.css",
          "%1.component.html",
          "%1.component.less",
          "%1.component.sass",
          "%1.component.scss",
          "%1.component.spec.ts",
        },
      },
      ["C Sharp"] = {
        pattern = "^(.*)%.cs$",
        files = {
          "%1.Designer.cs",
          "%1.designer.cs",
        },
      },
      ["Cascading Style Sheets"] = {
        pattern = "^(.*)%.css$",
        files = {
          "%1.css.map",
          "%1.min.css",
          "%1.min.css.map",
        },
      },
      ["eXtensible Application Markup Language"] = {
        pattern = "^(.*)%.xaml$",
        files = {
          "%1.xaml.cs",
        },
      },
      ["JavaScript"] = {
        pattern = "^(.*)%.js$",
        files = {
          "%1.js.map",
          "%1.min.js",
          "%1.min.js.map",
          "%1.spec.js",
          "%1.test.js",
        },
      },
      ["JavaScript esModules"] = {
        pattern = "^(.*)%.mjs$",
        files = {
          "%1.mjs.map",
          "%1.min.mjs",
          "%1.min.mjs.map",
          "%1.spec.mjs",
          "%1.test.mjs",
        },
      },
      ["Node package manifest"] = {
        pattern = "^package%.json$",
        files = {
          "package-lock.json",
          "yarn*",
        },
      },
      ["Razor components"] = {
        pattern = "^(.*)%.razor$",
        files = {
          "%1.razor.cs",
          "%1.razor.css",
          "%1.razor.js",
        },
      },
      ["Razor pages"] = {
        pattern = "^(.*)%.cshtml$",
        files = {
          "%1.cshtml.cs",
          "%1.cshtml.js",
        },
      },
      ["Scalable Vector Graphics"] = {
        pattern = "^(.*)%.svg$",
        files = {
          "%1.min.svg",
        },
      },
      ["TypeScript"] = {
        pattern = "^(.*)%.ts$",
        files = {
          "%1.spec.ts",
          "%1.test.ts",
        },
      },
    },
    window = {
      mappings = {
        ["<C-h>"] = {
          desc = "neo-tree: Go to parent",
          function(state)
            local node = state.tree:get_node()
            require("neo-tree.ui.renderer").focus_node(
              state,
              node:get_parent_id()
            )
          end,
        },
        ["<C-j>"] = {
          desc = "neo-tree: Go to next sibling",
          function(state)
            local node = state.tree:get_node()
            local siblings = get_siblings(state, node)
            if not node.is_last_child then
              local current_index = index_of(siblings, node.id)
              local next_index = siblings[current_index + 1]
              require("neo-tree.ui.renderer").focus_node(state, next_index)
            end
          end,
        },
        ["<C-k>"] = {
          desc = "neo-tree: Go to previous sibling",
          function(state)
            local node = state.tree:get_node()
            local siblings = get_siblings(state, node)
            local current_index = index_of(siblings, node.id)
            if current_index > 1 then
              local previous_index = siblings[current_index - 1]
              require("neo-tree.ui.renderer").focus_node(state, previous_index)
            end
          end,
        },
        ["<C-s>"] = "split_with_window_picker",
        ["<C-t>"] = "open_tabnew",
        ["<C-v>"] = "vsplit_with_window_picker",
        ["<CR>"] = "open",
        ["<Space>"] = { "toggle_node", nowait = true },
        ["[g"] = "none",
        ["]g"] = "none",
        J = {
          desc = "neo-tree: Go to last sibling",
          function(state)
            local node = state.tree:get_node()
            local siblings = get_siblings(state, node)
            require("neo-tree.ui.renderer").focus_node(
              state,
              siblings[#siblings]
            )
          end,
        },
        K = {
          desc = "neo-tree: Go to first sibling",
          function(state)
            local node = state.tree:get_node()
            local siblings = get_siblings(state, node)
            require("neo-tree.ui.renderer").focus_node(state, siblings[1])
          end,
        },
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
      hijack_netrw_behavior = "disabled",
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
