-- cspell:words autopairs conds

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "windwp/nvim-autopairs",
  config = true,
  init = function()
    local has_autopairs, nvim_autopairs = pcall(require, "nvim-autopairs")
    if not has_autopairs then
      return
    end

    nvim_autopairs.add_rules {
      require "nvim-autopairs.rule"("{{", "  }", "vue")
        :set_end_pair_length(2)
        :with_pair(require("nvim-autopairs.ts-conds").is_ts_node "text"),
    }
  end,
}
