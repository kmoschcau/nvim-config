local lazy_path = vim.fs.joinpath(vim.fn.stdpath "data", "lazy", "lazy.nvim")

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  vim.api.nvim_echo({ { "Cloning lazy.nvim…\n" } }, true, { kind = "echo" })
  local result = vim
    .system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazy_path,
    }, { text = true })
    :wait()

  if result.code ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { result.stderr, "ErrorMsg" },
      { result.stdout, "WarningMsg" },
    }, true, { kind = "emsg" })
  end
end

vim.opt.rtp:prepend(lazy_path)
