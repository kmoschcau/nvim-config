local config_name = ".lvimrc.json"

local default_config = {
  null_ls = {
    java = {
      checkstyle = {
        file = false,
        config = nil,
        options = nil,
      },
      pmd = {
        dir = nil,
        rulesets = nil,
        cache = nil,
      },
    },
  },
}

local function file_exists(file_name)
  local file = io.open(file_name, "rb")
  if file then
    file:close()
  end
  return file ~= nil
end

local function get_config_paths()
  local dirs = {}
  for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
    table.insert(dirs, dir)
  end

  local config_paths = {}
  for i = #dirs, 1, -1 do
    local config_path = dirs[i] .. "/" .. config_name
    if file_exists(config_path) then
      table.insert(config_paths, config_path)
    end
  end
  return config_paths
end

local function get_lines(file_name)
  if not file_exists(file_name) then
    return {}
  end
  local lines = {}
  for line in io.lines(file_name) do
    table.insert(lines, line)
  end
  return lines
end

return {
  get_config = function()
    local effective_conf = default_config
    for _, config_path in ipairs(get_config_paths()) do
      effective_conf = vim.tbl_deep_extend(
        "force",
        effective_conf,
        vim.fn.json_decode(get_lines(config_path))
      )
    end
    return effective_conf
  end,
}
