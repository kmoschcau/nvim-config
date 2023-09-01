return {
  "antosha417/nvim-lsp-file-operations",
  cmd = {
    "NvimTreeOpen",
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
  },
  keys = {
    {
      "<C-n>",
      function()
        require("nvim-tree.api").tree.toggle()
      end,
      desc = "Toggle the nvim-tree window.",
      silent = true,
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-tree.lua",
  },
}
