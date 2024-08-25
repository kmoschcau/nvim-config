--- @type LazyPluginSpec
return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    local action_state = require "telescope.actions.state"
    local actions = require "telescope.actions"
    local conf = require("telescope.config").values
    local finders = require "telescope.finders"
    local pickers = require "telescope.pickers"

    dap.adapters.netcoredbg = {
      type = "executable",
      command = require("system-compat").append_win_ext("netcoredbg", "exe"),
      args = { "--interpreter=vscode" },
    }

    --- @type dap.Configuration[]
    dap.configurations.cs = {
      {
        name = "Launch - ASP.NET Core",
        type = "netcoredbg",
        request = "launch",
        justMyCode = false,
        stopAtEntry = false,
        env = {
          ASPNETCORE_ENVIRONMENT = "Development",
          ASPNETCORE_URLS = "http://localhost:5274",
        },
        cwd = function()
          return coroutine.create(function(dap_cwd_coro)
            pickers
              .new({}, {
                prompt_title = "Project working directory (via csproj)",
                finder = finders.new_oneshot_job(
                  { "fd", "--extension", "csproj" },
                  {}
                ),
                sorter = conf.generic_sorter {},
                attach_mappings = function(buf, map)
                  actions.select_default:replace(function()
                    actions.close(buf)
                    local work_dir = vim.fs.normalize(
                      vim.fs.dirname(
                        vim.fs.joinpath(
                          vim.fn.getcwd(),
                          action_state.get_selected_entry()[1]
                        )
                      )
                    )
                    coroutine.resume(dap_cwd_coro, work_dir)
                  end)

                  map({ "i", "n" }, "<C-c>", function(bufnr)
                    actions.close(bufnr)
                    coroutine.resume(dap_cwd_coro, dap.ABORT)
                  end)

                  return true
                end,
              })
              :find()
          end)
        end,
        program = function()
          return coroutine.create(function(dap_program_coro)
            local function select_dll()
              pickers
                .new({}, {
                  prompt_title = "dll to debug",
                  finder = finders.new_oneshot_job({
                    "fd",
                    "--full-path",
                    "--no-ignore",
                    "--extension",
                    "dll",
                    "bin[\\\\/]Debug",
                  }, {}),
                  sorter = conf.generic_sorter {},
                  attach_mappings = function(buf, map)
                    actions.select_default:replace(function()
                      actions.close(buf)
                      local dll = vim.fs.normalize(
                        vim.fs.joinpath(
                          vim.fn.getcwd(),
                          action_state.get_selected_entry()[1]
                        )
                      )
                      coroutine.resume(dap_program_coro, dll)
                    end)

                    map({ "i", "n" }, "<C-c>", function(bufnr)
                      actions.close(bufnr)
                      coroutine.resume(dap_program_coro, dap.ABORT)
                    end)

                    return true
                  end,
                })
                :find()
            end

            if
              vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1
            then
              pickers
                .new({}, {
                  prompt_title = "csproj to build",
                  finder = finders.new_oneshot_job(
                    { "fd", "--extension", "csproj" },
                    {}
                  ),
                  sorter = conf.generic_sorter {},
                  attach_mappings = function(buf, map)
                    actions.select_default:replace(function()
                      actions.close(buf)
                      local csproj = vim.fs.normalize(
                        vim.fs.joinpath(
                          vim.fn.getcwd(),
                          action_state.get_selected_entry()[1]
                        )
                      )
                      local result = vim
                        .system({
                          "dotnet",
                          "build",
                          csproj,
                          "--configuration",
                          "Debug",
                        }, { text = true })
                        :wait()
                      if result.code == 0 then
                        vim.notify("✔", vim.log.levels.INFO, {
                          title = "Build",
                        })
                        select_dll()
                      else
                        vim.notify("❌", vim.log.levels.ERROR, {
                          title = "Build",
                        })
                        coroutine.resume(dap_program_coro, dap.ABORT)
                      end
                    end)

                    map({ "i", "n" }, "<C-c>", function(bufnr)
                      actions.close(bufnr)
                      coroutine.resume(dap_program_coro, dap.ABORT)
                    end)

                    return true
                  end,
                })
                :find()
            else
              select_dll()
            end
          end)
        end,
      },
    }

    dap.configurations.java = {
      {
        name = "Debug (Attach) - Remote",
        type = "java",
        request = "attach",
        hostName = "127.0.0.1",
        port = 5005,
      },
    }

    vim.keymap.set("n", "<F4>", dap.continue, {
      desc = "Dap: Start debugging or continue a stopped thread.",
    })
    vim.keymap.set("n", "<M-d>B", dap.toggle_breakpoint, {
      desc = "Dap: Toggle a breakpoint.",
    })
    vim.keymap.set("n", "<M-d>b", dap.set_breakpoint, {
      desc = "Dap: Set a breakpoint.",
    })
    vim.keymap.set("n", "<M-d>c", function()
      vim.ui.input({ prompt = "Condition:" }, function(input)
        if input and #input then
          dap.set_breakpoint(input)
        end
      end)
    end, { desc = "Dap: Set a conditional breakpoint." })
    vim.keymap.set("n", "<M-d>l", function()
      vim.ui.input({ prompt = "Log point message:" }, function(input)
        if input and #input then
          dap.set_breakpoint(nil, nil, input)
        end
      end)
    end, { desc = "Dap: Set a logpoint." })

    local function set_dynamic_keymaps()
      vim.keymap.set("n", "<F5>", dap.run_to_cursor, {
        desc = "Dap: Run to the cursor.",
      })
      vim.keymap.set("n", "<F6>", dap.step_over, {
        desc = "Dap: Step over the current line.",
      })
      vim.keymap.set("n", "<F7>", dap.step_into, {
        desc = "Dap: Step into the next function.",
      })
      vim.keymap.set("n", "<F19>", function()
        dap.step_into { askForTargets = true }
      end, {
        desc = "Dap: Step into a function with target selection.",
      })
      vim.keymap.set("n", "<F8>", dap.step_out, {
        desc = "Dap: Step out of the function.",
      })
      vim.keymap.set({ "n", "x" }, "<M-k>", dapui.eval, {
        desc = "Dap: Hover.",
      })
    end

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()

      set_dynamic_keymaps()
    end

    dap.listeners.after.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.after.event_exited["dapui_config"] = function()
      dapui.close()
    end

    local debug = require("symbols").debug
    vim.fn.sign_define("DapBreakpoint", {
      text = debug.breakpoint.normal,
      texthl = "DapBreakpoint",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = debug.breakpoint.conditional,
      texthl = "DapBreakpointCondition",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = debug.breakpoint.log,
      texthl = "DapLogPoint",
    })
    vim.fn.sign_define("DapStopped", {
      text = debug.current_frame,
      texthl = "DapStopped",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = debug.breakpoint.rejected,
      texthl = "DapBreakpointRejected",
    })
  end,
}
