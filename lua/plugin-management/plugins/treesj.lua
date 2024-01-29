--- @type LazyPluginSpec
return {
  "Wansmer/treesj",
  keys = {
    {
      "<space>m",
      function()
        require("treesj").toggle()
      end,
      desc = "treesj: Toggle join/split.",
    },
    {
      "<space>j",
      function()
        require("treesj").join()
      end,
      desc = "treesj: Join.",
    },
    {
      "<space>sp",
      function()
        require("treesj").split()
      end,
      desc = "treesj: Split.",
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
  },
}
