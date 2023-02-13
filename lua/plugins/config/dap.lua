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
  desc = "Start debugging or continue a stopped thread.",
  silent = true,
})
vim.keymap.set("n", "<M-d>B", dap.toggle_breakpoint, {
  desc = "Toggle a breakpoint.",
  silent = true,
})
vim.keymap.set("n", "<M-d>b", dap.set_breakpoint, {
  desc = "Set a breakpoint.",
  silent = true,
})
vim.keymap.set("n", "<M-d>c", function()
  vim.ui.input({ prompt = "Condition:" }, function(input)
    if input and #input then
      dap.set_breakpoint(input)
    end
  end)
end, {
  desc = "Set a conditional breakpoint.",
  silent = true,
})
vim.keymap.set("n", "<M-d>l", function()
  vim.ui.input({ prompt = "Log point message:" }, function(input)
    if input and #input then
      dap.set_breakpoint(nil, nil, input)
    end
  end)
end, {
  desc = "Set a logpoint.",
  silent = true,
})

local function set_dynamic_keymaps()
  vim.keymap.set("n", "<F5>", dap.run_to_cursor, {
    desc = "Run to the cursor.",
    silent = true,
  })
  vim.keymap.set("n", "<F6>", dap.step_over, {
    desc = "Step over the current line.",
    silent = true,
  })
  vim.keymap.set("n", "<F7>", dap.step_into, {
    desc = "Step into the next function.",
    silent = true,
  })
  vim.keymap.set("n", "<F19>", function()
    dap.step_into { askForTargets = true }
  end, {
    desc = "Step into a function with target selection.",
    silent = true,
  })
  vim.keymap.set("n", "<F8>", dap.step_out, {
    desc = "Step out of the function.",
    silent = true,
  })
  vim.keymap.set({ "n", "v" }, "<M-k>", dapui.eval, {
    desc = "Trigger a DAP hover.",
    silent = true,
  })
end

local function delete_dynamic_keymaps()
  vim.keymap.del("n", "<F5>")
  vim.keymap.del("n", "<F6>")
  vim.keymap.del("n", "<F7>")
  vim.keymap.del("n", "<F19>")
  vim.keymap.del("n", "<F8>")
  vim.keymap.del({ "n", "v" }, "<M-k>")
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()

  set_dynamic_keymaps()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()

  delete_dynamic_keymaps()
end

dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.close()

  delete_dynamic_keymaps()
end

vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "Material_SignBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
  text = "",
  texthl = "Material_SignBreakpointConditional",
})
vim.fn.sign_define("DapLogPoint", {
  text = "",
  texthl = "Material_SignLogpoint",
})
vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "Material_SignCurrentFrame",
})
vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "Material_SignBreakpointRejected",
})

local augroup = vim.api.nvim_create_augroup("InitDap", {})
vim.api.nvim_create_autocmd("FileType", {
  desc = "Automatically trigger completions in the repl on completion chars.",
  group = augroup,
  pattern = "dap-repl",
  callback = require("dap.ext.autocompl").attach,
})
