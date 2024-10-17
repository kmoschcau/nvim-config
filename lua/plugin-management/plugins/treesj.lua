-- selene: allow(mixed_table)
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
  opts = {
    use_default_keymaps = false,
  },
}
