---@type vim.lsp.Config
return {
  cmd = require("kmo.lsp.common.roslyn").get_roslyn_cmd(),
  root_dir = function(bufnr, cb)
    local config =
      require("neoconf").get("lsp", require("neoconf-schemas.lsp").defaults)
    if config.dotnet_server ~= "roslyn_ls" then
      return
    end

    local bufname = vim.api.nvim_buf_get_name(bufnr)
    -- don't try to find sln or csproj for files from libraries
    -- outside of the project
    if not bufname:match("^" .. vim.fs.joinpath "/tmp/MetadataAsSource/") then
      -- try find solutions root first
      local root_dir = vim.fs.root(bufnr, function(fname, _)
        return fname:match "%.sln$" ~= nil
      end)

      if not root_dir then
        -- try find projects root
        root_dir = vim.fs.root(bufnr, function(fname, _)
          return fname:match "%.csproj$" ~= nil
        end)
      end

      if root_dir then
        cb(root_dir)
      end
    end
  end,
}
