--- @type LazyPluginSpec
return {
  "gregorias/coerce.nvim",
  config = function()
    local coerce = require "coerce"

    local selector_m = require "coerce.selector"
    local transformer_m = require "coerce.transformer"

    coerce.setup {
      modes = {},
    }

    coerce.register_mode {
      vim_mode = "n",
      keymap_prefix = "<Space>cc",
      selector = selector_m.select_current_word,
      transformer = function(selected_region, apply)
        return require("coerce.coroutine").fire_and_forget(
          transformer_m.transform_lsp_rename_with_local_failover,
          selected_region,
          apply
        )
      end,
    }

    coerce.register_mode {
      vim_mode = "n",
      keymap_prefix = "<Space>cr",
      selector = selector_m.select_with_motion,
      transformer = transformer_m.transform_local,
    }

    coerce.register_mode {
      vim_mode = "x",
      keymap_prefix = "<Space>cr",
      selector = selector_m.select_current_visual_selection,
      transformer = transformer_m.transform_local,
    }
  end,
}
