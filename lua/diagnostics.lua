vim.diagnostic.config {
  float = {
    source = true,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = require("symbols").diagnostics.severities.error,
      [vim.diagnostic.severity.WARN] = require("symbols").diagnostics.severities.warn,
      [vim.diagnostic.severity.INFO] = require("symbols").diagnostics.severities.info,
      [vim.diagnostic.severity.HINT] = require("symbols").diagnostics.severities.hint,
    },
  },
}

vim.api.nvim_create_user_command("DiagnosticsSeverity", function(args)
  local argument = args.fargs[1]
  local severity
  if argument then
    local sev = vim.diagnostic.severity[argument]
    if not sev then
      vim.notify(
        "An invalid argument was provided: " .. argument,
        vim.log.levels.ERROR,
        { title = args.name }
      )
      return
    end

    severity = sev
  else
    severity = vim.diagnostic.severity.HINT
  end

  local current_config = vim.diagnostic.config()
  if not current_config then
    return
  end

  local function set_min_severity(key)
    if current_config[key] then
      if type(current_config[key]) == "table" then
        current_config[key].severity = { min = severity }
      elseif type(current_config[key]) == "boolean" then
        current_config[key] = { severity = { min = severity } }
      end
    end
  end

  for _, key in ipairs {
    "underline",
    "virtual_text",
    "virtual_lines",
    "signs",
    "float",
    "jump",
  } do
    set_min_severity(key)
  end

  vim.diagnostic.config(current_config)
end, {
  bar = true,
  complete = function()
    local candidates = {}

    for key, _ in pairs(vim.diagnostic.severity) do
      candidates[#candidates + 1] = key
    end

    return candidates
  end,
  desc = "Diagnostics: Set the minimum severity level of in-buffer diagnostics",
  nargs = "?",
})

vim.keymap.set("n", "<Space>dl", function()
  local old_config = vim.diagnostic.config().virtual_lines
  if old_config then
    vim.diagnostic.config { virtual_lines = false }
    return
  end

  vim.diagnostic.config {
    virtual_lines = {
      format = function(diagnostic)
        if diagnostic.code then
          return string.format(
            "%s: %s [%s]",
            diagnostic.source,
            diagnostic.message,
            diagnostic.code
          )
        end

        return string.format("%s: %s", diagnostic.source, diagnostic.message)
      end,
    },
  }
end, { desc = "Diagnostics: Toggle showing virtual lines." })

vim.keymap.set("n", "<Space>L", vim.diagnostic.setloclist, {
  desc = "Diagnostics: Put all buffer diagnostics in the location list.",
})

vim.keymap.set("n", "<Space>le", function()
  vim.diagnostic.setloclist {
    severity = { min = vim.diagnostic.severity.ERROR },
    title = "Error diagnostics",
  }
end, {
  desc = "Diagnostics: Put all buffer error diagnostics in the location list.",
})

vim.keymap.set("n", "<Space>lw", function()
  vim.diagnostic.setloclist {
    severity = { min = vim.diagnostic.severity.WARN },
    title = "Warning and higher diagnostics",
  }
end, {
  desc = "Diagnostics: Put all buffer warning and higher diagnostics in the location list.",
})

vim.keymap.set("n", "<Space>li", function()
  vim.diagnostic.setloclist {
    severity = { min = vim.diagnostic.severity.INFO },
    title = "Info and higher diagnostics",
  }
end, {
  desc = "Diagnostics: Put all buffer info and higher diagnostics in the location list.",
})

vim.keymap.set("n", "<Space>Q", vim.diagnostic.setqflist, {
  desc = "Diagnostics: Put all project diagnostics in the quickfix list.",
})

vim.keymap.set("n", "<Space>qe", function()
  vim.diagnostic.setqflist {
    severity = { min = vim.diagnostic.severity.ERROR },
    title = "Error diagnostics",
  }
end, {
  desc = "Diagnostics: Put all project error diagnostics in the quickfix list.",
})

vim.keymap.set("n", "<Space>qw", function()
  vim.diagnostic.setqflist {
    severity = { min = vim.diagnostic.severity.WARN },
    title = "Warning and higher diagnostics",
  }
end, {
  desc = "Diagnostics: Put all project warning and higher diagnostics in the quickfix list.",
})

vim.keymap.set("n", "<Space>qi", function()
  vim.diagnostic.setqflist {
    severity = { min = vim.diagnostic.severity.INFO },
    title = "Info and higher diagnostics",
  }
end, {
  desc = "Diagnostics: Put all project info and higher diagnostics in the quickfix list.",
})
