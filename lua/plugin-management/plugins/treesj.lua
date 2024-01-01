return {
  "Wansmer/treesj",
  keys = {
    {
      "<space>m",
      function()
        require("treesj").toggle()
      end,
      desc = "Toggle treesj joining.",
    },
    {
      "<space>j",
      function()
        require("treesj").join()
      end,
      desc = "treesj join.",
    },
    {
      "<space>sp",
      function()
        require("treesj").split()
      end,
      desc = "treesj split.",
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
  },
}
