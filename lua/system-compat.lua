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

return M
