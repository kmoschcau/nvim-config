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
    local ts_conds = require "nvim-autopairs.ts-conds"

    autopairs.add_rules {
      rule("{{", "  }", "vue")
        :set_end_pair_length(2)
        :with_pair(ts_conds.is_ts_node "text"),
      rule("<!--", "  -->", "vue"):set_end_pair_length(4),
    }
  end,
}
