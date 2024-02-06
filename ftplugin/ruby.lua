-- vim: foldmethod=marker
-- Ruby file type settings

-- general Neovim settings {{{1
-- key maps {{{2

local rspec_executable = "rspec --format progress"
local last_spec = nil

local function and_command()
  local result = vim.system({ "echo", "-n", "$SHELL" }, { text = true }):wait()
  if result.code == 0 and vim.regex("fish$"):match_str(result.stdout) then
    return "; and "
  else
    return " && "
  end
end

local function create_command(spec_location)
  return "!echo "
    .. rspec_executable
    .. " "
    .. spec_location
    .. and_command()
    .. rspec_executable
    .. " "
    .. spec_location
end

local function run_specs(spec_location)
  vim.cmd(create_command(spec_location))
end

local function is_in_spec_file()
  return not vim.regex("_spec$"):match_str(vim.fn.expand "%:t:r") == nil
end

if is_in_spec_file() then
  vim.keymap.set("n", "<Space>sf", function()
    last_spec = vim.fn.expand "%"
    run_specs(last_spec)
  end, {
    buffer = true,
    silent = true,
    desc = "RSpec: Run all specs.",
  })
  vim.keymap.set("n", "<Space>sl", function()
    last_spec = vim.fn.expand "%" .. ":" .. vim.fn.line "."
    run_specs(last_spec)
  end, {
    buffer = true,
    silent = true,
    desc = "RSpec: Run all specs.",
  })
  vim.keymap.set("n", "<Space>s.", function()
    if last_spec then
      run_specs(last_spec)
    end
  end, {
    buffer = true,
    silent = true,
    desc = "RSpec: Repeat the last spec run.",
  })
  vim.keymap.set("n", "<Space>sa", function()
    last_spec = ""
    run_specs(last_spec)
  end, {
    buffer = true,
    silent = true,
    desc = "RSpec: Run all specs.",
  })
end
