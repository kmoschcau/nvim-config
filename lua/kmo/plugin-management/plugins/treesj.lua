-- cspell:words splitjoin treesj

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
  "Wansmer/treesj",
  dependencies = {
    -- cspell:disable
    "nvim-mini/mini.nvim",
    -- cspell:enable
  },
  config = function()
    local treesj = require "treesj"
    treesj.setup {
      use_default_keymaps = false,
    }

    local langs = require("treesj.langs").presets

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = vim.api.nvim_create_augroup("treesj", {}),
      desc = "Treesj/mini.nvim: Set up join and split keymaps.",
      callback = function()
        if langs[vim.bo.filetype] then
          vim.keymap.set("n", "<Space>m", treesj.toggle, {
            buffer = true,
            desc = "treesj: Toggle join/split.",
          })
          vim.keymap.set("n", "<Space>j", treesj.join, {
            buffer = true,
            desc = "treesj: Join.",
          })
          vim.keymap.set("n", "<Space>sp", treesj.split, {
            buffer = true,
            desc = "treesj: Split.",
          })
        else
          vim.keymap.set(
            "n",
            "<Space>m",
            "<Cmd>lua MiniSplitjoin.toggle()<CR>",
            {
              buffer = true,
              desc = "mini.splitjoin: Toggle join/split.",
            }
          )
          vim.keymap.set("n", "<Space>j", "<Cmd>lua MiniSplitjoin.join()<CR>", {
            buffer = true,
            desc = "mini.splitjoin: Join.",
          })
          vim.keymap.set(
            "n",
            "<Space>sp",
            "<Cmd>lua MiniSplitjoin.split()<CR>",
            {
              buffer = true,
              desc = "mini.splitjoin: Split.",
            }
          )
        end
      end,
    })
  end,
}
