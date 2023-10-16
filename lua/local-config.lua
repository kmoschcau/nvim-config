local config_name = ".lvimrc.json"

-- TODO: improve this with vim.secure module

--- @class LocalConfigNoneLsJavaCheckstyle
--- @field file boolean Whether to use file or project wide linting
--- @field config string | nil The file name for the config file XML
--- @field options string | nil Additional options for checkstyle

--- @class LocalConfigNoneLsJavaPmd
--- @field dir string | nil The run directory for PMD
--- @field rulesets string | nil The rulesets for PMD
--- @field cache string | nil The cache file path, if used

--- @class LocalConfigNoneLsJava
--- @field checkstyle LocalConfigNoneLsJavaCheckstyle Checkstyle options
--- @field pmd LocalConfigNoneLsJavaPmd PMD options

--- @class LocalConfigNoneLs
--- @field java LocalConfigNoneLsJava Java specific options

--- @class LocalConfig
--- @field none_ls LocalConfigNoneLs Options for none-ls

--- @type LocalConfig
local default_config = {
  none_ls = {
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

--- Check if a file with the given file name exists.
--- @param file_name string The file name to check
--- @return boolean result Whether the file exists
local function file_exists(file_name)
  local file = io.open(file_name, "rb")
  if file then
    file:close()
  end
  return file ~= nil
end

--- Get a table of file names for existing config files.
--- @return string[] paths The paths with existing config files
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

--- Get the content of the file with the given file name.
--- @param file_name string The name of the file
--- @return string[] content The file contents
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
  --- Get the local config.
  --- @return LocalConfig config The effective config
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
