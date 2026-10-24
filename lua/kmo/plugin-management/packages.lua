---@param path string
local function cb(path)
  return "https://codeberg.org/" .. path
end

---@param path string
local function gh(path)
  return "https://github.com/" .. path
end

vim.opt.packpath:append(
  vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath "data", "site"))
)

local names = {
  blink_cmp = "blink.cmp",
}

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Build plugins that need it",
  group = vim.api.nvim_create_augroup("kmo.pack.build", {}),
  callback = function(event)
    --- @type vim.event.packchanged.data
    local data = event.data
    local name, kind, path = data.spec.name, data.kind, data.path
  end,
})

vim.pack.add {
  -- cspell:disable
  { src = gh "AckslD/muren.nvim" },

  { src = gh "folke/neoconf.nvim" },

  { src = gh "gregorias/coop.nvim" },
  { src = gh "gregorias/coerce.nvim" },

  { src = gh "hat0uma/csvview.nvim" },

  { src = gh "icholy/lsplinks.nvim" },

  { src = gh "Kicamon/markdown-table-mode.nvim" },

  { src = gh "rafamadriz/friendly-snippets" },
  { src = gh "L3MON4D3/LuaSnip" },

  { src = gh "lewis6991/gitsigns.nvim" },

  { src = gh "lukas-reineke/indent-blankline.nvim" },

  { src = gh "luukvbaal/statuscol.nvim" },

  { src = gh "MagicDuck/grug-far.nvim" },

  { src = gh "MoaidHathot/dotnet.nvim" },

  { src = cb "mfussenegger/nvim-lint" },

  { src = gh "monaqa/dial.nvim" },

  { src = gh "SmiteshP/nvim-navic" },
  { src = gh "nvim-lualine/lualine.nvim" },

  { src = gh "nvim-mini/mini.nvim" },

  { src = gh "Bilal2453/luvit-meta" },
  { src = gh "DrKJeff16/wezterm-types" },
  { src = gh "folke/lazydev.nvim" },
  { src = gh "micangl/cmp-vimtex" },
  { src = gh "moyiz/blink-emoji.nvim" },
  { src = gh "mtoohey31/cmp-fish" },
  { src = gh "rcarriga/cmp-dap" },
  { src = gh "ribru17/blink-cmp-spell" },
  { src = gh "saghen/blink.compat" },
  { src = gh "xzbdmw/colorful-menu.nvim" },
  { src = gh "saghen/blink.cmp", version = vim.version.range "^1.10.2" },

  { src = gh "stevearc/conform.nvim" },
  -- cspell:enable
}

for _, ft_path in
  ipairs(
    vim.api.nvim_get_runtime_file(
      "lua/kmo/plugin-management/package-configs/*.lua",
      true
    )
  )
do
  loadfile(ft_path)()
end
