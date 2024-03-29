local M = {}

--- Append a file extension (default: "cmd") to the given base name, when
--- running on Windows. Otherwise this returns the given base name.
--- @param baseName string the base name to extend
--- @param ext? string the extension to append, when on Windows
--- @return string
M.append_win_ext = function(baseName, ext)
  if vim.fn.has "win32" == 0 then
    return baseName
  end

  return baseName .. "." .. (ext or "cmd")
end

--- Try and get the appropriate browser command for the environment neovim is
--- running in.
--- @return string?
M.get_browser_command = function()
  if vim.fn.executable "xdg-open" == 1 then
    return "xdg-open"
  end

  if vim.fn.executable "wslview" == 1 then
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

--- Try to determine the system background (or dark mode). If it can't be
--- determined, fall back to "dark".
--- @return "light" | "dark"
M.get_system_background = function()
  if vim.fn.has "win32" == 1 or M.is_running_in_wsl() then
    local result = vim
      .system({
        "reg.exe",
        "query",
        "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize",
        "/v",
        "AppsUseLightTheme",
      }, { text = true })
      :wait()

    if result.code ~= 0 then
      vim.notify('Calling "reg.exe" failed.', vim.log.levels.ERROR)
      return "dark"
    end

    return result.stdout:match "0x1" and "light" or "dark"
  end

  if vim.fn.executable "darkman" == 1 then
    local result = vim.system({ "darkman", "get" }, { text = true }):wait()

    if result.code > 0 then
      return "dark"
    end

    return (result.stdout:gsub("%s+", "") == "dark") and "dark" or "light"
  end

  return "dark"
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

--- Set the options common for a dos formatted file for the current buffer.
M.set_dos_file_options = function()
  vim.opt_local.endofline = false
  vim.opt_local.fixendofline = false
  if vim.opt_local.modifiable:get() then
    vim.opt_local.fileformat = "dos"
  end
end

return M
