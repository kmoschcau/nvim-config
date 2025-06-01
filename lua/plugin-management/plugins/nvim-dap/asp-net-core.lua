local dap = require "dap"
local symbols = require "symbols"

local M = {}

local build_notification_id = "asp_net_build_progress"
local title = "nvim-dap"

local function handle_no_snacks(dap_coroutine)
  vim.notify(
    "Snacks is not installed. Could not create a picker.",
    vim.log.levels.ERROR,
    { title = title }
  )
  coroutine.resume(dap_coroutine, dap.ABORT)
end

---@param picker snacks.Picker
local function handle_no_selection(picker, dap_coroutine)
  vim.notify("The selected item was null.", vim.log.levels.ERROR, {
    title = title,
  })
  picker:close()
  coroutine.resume(dap_coroutine, dap.ABORT)
end

---Creates a function for the Snacks picker cancel action.
---@return fun(picker: snacks.Picker)
local function create_cancel(dap_coroutine)
  ---@param picker snacks.Picker
  return function(picker)
    picker:close()
    coroutine.resume(dap_coroutine, dap.ABORT)
  end
end

local function select_cwd(dap_coroutine)
  local has_snacks, snacks = pcall(require, "snacks")
  if not has_snacks then
    handle_no_snacks(dap_coroutine)
    return
  end

  snacks.picker.files {
    ft = "csproj",
    title = "Project working directory (via csproj)",
    actions = {
      confirm = function(picker)
        picker:close()

        local item = picker:current()
        if not item then
          handle_no_selection(picker, dap_coroutine)
          return
        end

        local work_dir = vim.fs.normalize(
          vim.fs.dirname(vim.fs.joinpath(picker:cwd(), item.file))
        )

        coroutine.resume(dap_coroutine, work_dir)
      end,

      cancel = create_cancel(dap_coroutine),
    },
  }
end

local function select_dll(dap_coroutine)
  local has_snacks, snacks = pcall(require, "snacks")
  if not has_snacks then
    handle_no_snacks(dap_coroutine)
    return
  end

  snacks.picker.files {
    args = { "--full-path" },
    cmd = "fd",
    ft = "dll",
    ignored = true,
    search = "bin[\\\\/]Debug",
    title = "DLL to debug",
    actions = {
      confirm = function(picker)
        picker:close()

        local item = picker:current()
        if not item then
          handle_no_selection(picker, dap_coroutine)
          return
        end

        local dll = vim.fs.normalize(vim.fs.joinpath(picker:cwd(), item.file))

        coroutine.resume(dap_coroutine, dll)
      end,

      cancel = create_cancel(dap_coroutine),
    },
  }
end

local function select_and_build_csproj(dap_coroutine)
  local has_snacks, snacks = pcall(require, "snacks")
  if not has_snacks then
    handle_no_snacks(dap_coroutine)
    return
  end

  snacks.picker.files {
    ft = "csproj",
    title = "csproj to build",
    actions = {
      confirm = function(picker)
        picker:close()

        local item = picker:current()
        if not item then
          handle_no_selection(picker, dap_coroutine)
          return
        end

        local csproj =
          vim.fs.normalize(vim.fs.joinpath(picker:cwd(), item.file))

        vim.system(
          {
            "dotnet",
            "build",
            csproj,
            "--configuration",
            "Debug",
          },
          { text = true },
          vim.schedule_wrap(function(result)
            if result.code == 0 then
              vim.notify("Build succeeded", vim.log.levels.INFO, {
                id = build_notification_id,
                icon = symbols.progress.done,
                title = title,
              })
              select_dll(dap_coroutine)
            else
              vim.notify("Build failed", vim.log.levels.ERROR, {
                id = build_notification_id,
                title = title,
              })
              coroutine.resume(dap_coroutine, dap.ABORT)
            end
          end)
        )
        vim.notify("Building project", vim.log.levels.INFO, {
          id = build_notification_id,
          timeout = false,
          title = title,
          opts = function(notif)
            notif.icon = symbols.progress.get_dynamic_spinner()
          end,
        })
      end,

      cancel = create_cancel(dap_coroutine),
    },
  }
end

function M.cwd()
  return coroutine.create(select_cwd)
end

function M.program()
  return coroutine.create(function(dap_coroutine)
    vim.ui.select(
      { "Yes", "No" },
      { prompt = "Should I recompile first?" },
      function(choice)
        if choice == "Yes" then
          select_and_build_csproj(dap_coroutine)
        else
          select_dll(dap_coroutine)
        end
      end
    )
  end)
end

return M
