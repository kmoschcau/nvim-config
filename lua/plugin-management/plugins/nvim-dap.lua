return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
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
      vim.keymap.set({ "n", "v" }, "<M-k>", dapui.eval, {
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
      texthl = "Material_SignBreakpoint",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = debug.breakpoint.conditional,
      texthl = "Material_SignBreakpointConditional",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = debug.breakpoint.log,
      texthl = "Material_SignLogpoint",
    })
    vim.fn.sign_define("DapStopped", {
      text = debug.current_frame,
      texthl = "Material_SignCurrentFrame",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = debug.breakpoint.rejected,
      texthl = "Material_SignBreakpointRejected",
    })
  end,
}
