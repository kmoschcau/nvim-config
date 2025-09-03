-- cspell:words autopairs conds

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "windwp/nvim-autopairs",
  config = true,
  init = function()
    local has_autopairs, autopairs = pcall(require, "nvim-autopairs")
    if not has_autopairs then
      return
    end

    local rule = require "nvim-autopairs.rule"
    local conds = require "nvim-autopairs.conds"
    local ts_conds = require "nvim-autopairs.ts-conds"

    ---Adds a rule that handles inserting and deleting a specific character
    ---inside a pair.
    ---@param left string the left character of the pair
    ---@param insert string the inserted character
    ---@param right string the right character of the pair
    ---@param language? string an optional language to scope the rule
    local function add_paired_insertion_rule(left, insert, right, language)
      autopairs.add_rule(rule(insert, insert, language)
        :with_pair(function(opts)
          return left .. right
            == opts.line:sub(opts.col - #left, opts.col + #right - 1)
        end)
        :with_move(conds.none())
        :with_cr(conds.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          return left .. insert .. insert .. right
            == opts.line:sub(col - #left - #insert + 1, col + #insert + #right)
        end))
    end

    local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

    for _, pair in ipairs(brackets) do
      add_paired_insertion_rule(pair[1], " ", pair[2])
    end

    autopairs.add_rules {
      -- Add closing generic pair
      rule("<", ">", { "-html", "-javascriptreact", "-typescriptreact" })
        :with_pair(conds.before_regex("%a+:?:?$", 3))
        :with_move(function(opts)
          return opts.char == ">"
        end),

      -- Add trailing commas in Lua tables
      rule("{", "},", "lua"):with_pair(
        ts_conds.is_ts_node { "table_constructor" }
      ),
      rule("'", "',", "lua"):with_pair(
        ts_conds.is_ts_node { "table_constructor" }
      ),
      rule('"', '",', "lua"):with_pair(
        ts_conds.is_ts_node { "table_constructor" }
      ),

      -- Add spaces inside and complete vue template interpolation
      rule("{{", "  }", "vue")
        :set_end_pair_length(2)
        :with_pair(ts_conds.is_ts_node "text"),

      -- Add spaces inside and complete XML comment in vue
      rule("<!--", "  -->", "vue"):set_end_pair_length(4),
    }
  end,
}
