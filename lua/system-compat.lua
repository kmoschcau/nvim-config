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
  end

  return nil
end

return M
