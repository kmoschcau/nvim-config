--- @type LazyPluginSpec
return {
  "Wansmer/treesj",
  keys = {
    {
      "<Space>m",
      function()
        require("treesj").toggle()
      end,
      desc = "treesj: Toggle join/split.",
    },
    {
      "<Space>j",
      function()
        require("treesj").join()
      end,
      desc = "treesj: Join.",
    },
    {
      "<Space>sp",
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
