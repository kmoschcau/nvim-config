-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "windwp/nvim-autopairs",
  config = true,
  init = function()
    require("nvim-autopairs").add_rules {
      require "nvim-autopairs.rule"("{{", "  }", "vue")
        :set_end_pair_length(2)
        :with_pair(require("nvim-autopairs.ts-conds").is_ts_node "text"),
    }
  end,
}
