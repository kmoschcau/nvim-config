-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "JoosepAlviste/nvim-ts-context-commentstring",
  enabled = true,
  config = function()
    require("ts_context_commentstring").setup {
      enable_autocmd = false,
    }

    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == "commentstring"
          and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
    end
  end,
}
