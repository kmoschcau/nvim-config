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

vim.pack.add {
  -- cspell:disable
  { src = gh "L3MON4D3/LuaSnip" },
  { src = gh "rafamadriz/friendly-snippets" },
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
