local symbols = require "symbols"

-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  ---@type snacks.Config
  opts = {
    ---@type table<string, snacks.win.Config>
    styles = {
      input = {
        relative = "cursor",
        row = -3,
        col = 0,
      },
    },

    image = {},
    input = {},
    notifier = {
      padding = false,
      level = vim.log.levels.INFO,
      icons = symbols.log,
      style = "fancy",
    },
    picker = {
      icons = {
        diagnostics = {
          Error = symbols.diagnostics.severities.error,
          Warn = symbols.diagnostics.severities.warn,
          Info = symbols.diagnostics.severities.info,
          Hint = symbols.diagnostics.severities.hint,
        },
        kinds = symbols.types,
      },
    },
  },
  init = function()
    local snacks = require "snacks"

    vim.keymap.set("n", "<Space>P", snacks.picker.pick, {
      desc = "Snacks picker: Open pickers.",
    })

    vim.keymap.set("n", "<Space>pf", function()
      snacks.picker.files()
    end, { desc = "Snacks picker: Open file search." })

    vim.keymap.set("n", "<Space>pg", function()
      snacks.picker.grep()
    end, { desc = "Snacks picker: Open live grep search." })

    ---@type table<number, { token: lsp.ProgressToken, msg: string, done: boolean }[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ("[%3d%%] %s%s"):format(
                value.kind == "end" and 100 or value.percentage or 100,
                value.title or "",
                value.message and (" **%s**"):format(value.message) or ""
              ),
              done = value.kind == "end",
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and symbols.progress.done
              or symbols.progress.get_dynamic_spinner()
          end,
        })
      end,
    })
  end,
}
