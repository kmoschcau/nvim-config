local M = {}

--- Append a file extension (default: "cmd") to the given base name, when
--- running on Windows. Otherwise this returns the given base name.
--- @param baseName string the base name to extend
--- @param ext? string the extension to append, when on Windows
--- @return string
M.append_win_ext = function(baseName, ext)
  if vim.fn.has "win32" ~= 1 then
    return baseName
  end

  return baseName .. "." .. (ext or "cmd")
end

--- Try and get the appropriate browser command for the environment neovim is
--- running in.
--- @return string?
M.get_browser_command = function()
  if vim.fn.executable "xdg-open" > 0 then
    return "xdg-open"
  end

  if vim.fn.executable "wslview" > 0 then
    return "wslview"
  elseif M.is_running_in_wsl() then
    vim.notify(
      'Could not find "wslview", despite running in WSL.'
        .. ' Did you forget to install "wslu"?',
      vim.log.levels.WARN
    )
  end

  return nil
end

--- Try to determine whether the editor is running in a WSL environment.
--- @return boolean
M.is_running_in_wsl = function()
  if vim.fn.executable "uname" == 0 then
    return false
  end

  local result = vim.system({ "uname", "-r" }, { text = true }):wait()
  if result.code ~= 0 then
    vim.notify('Calling "uname" failed.', vim.log.levels.ERROR)
    return false
  end

  return result.stdout:match "microsoft"
end

return M
