local symbols = require "symbols"

-- selene: allow(mixed_table)
---@module "lazy"
---@type LazyPluginSpec
return {
  -- cspell:disable-next-line
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
      ---@diagnostic disable-next-line: missing-fields
      icons = {
        diagnostics = {
          Error = symbols.diagnostics.severities.error,
          Warn = symbols.diagnostics.severities.warn,
          Info = symbols.diagnostics.severities.info,
          Hint = symbols.diagnostics.severities.hint,
        },
        kinds = symbols.types,
      },
      layout = {
        preset = "ivy",
      },
    },
  },
  init = function()
    local has_snacks, snacks = pcall(require, "snacks")
    if not has_snacks then
      return
    end

    vim.keymap.set("n", "<Space>P", snacks.picker.pick, {
      desc = "Snacks picker: Open pickers.",
    })

    vim.keymap.set("n", "<Space>pf", function()
      snacks.picker.files()
    end, { desc = "Snacks picker: Open file search." })

    vim.keymap.set("n", "<Space>pg", function()
      snacks.picker.grep()
    end, { desc = "Snacks picker: Open live grep search." })

    vim.keymap.set("n", "<Space>pR", function()
      snacks.picker.resume()
    end, { desc = "Snacks picker: Resume the last picker." })

    vim.keymap.set("n", "<Space>prf", function()
      snacks.picker.resume { source = "files" }
    end, { desc = "Snacks picker: Resume the file search." })

    vim.keymap.set("n", "<Space>prg", function()
      snacks.picker.resume { source = "grep" }
    end, { desc = "Snacks picker: Resume the live grep search." })

    -- TODO: get rid of progress_by_client and just use separate notifications
    -- per token

    ---@type table<number, { token: lsp.ProgressToken, message: string, done: boolean }[]>
    local progress_by_client = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param event {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local value = event.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
          return
        end
        local client_progress = progress_by_client[client.id]

        for i = 1, #client_progress + 1 do
          if
            i == #client_progress + 1
            or client_progress[i].token == event.data.params.token
          then
            local message_parts = {}
            if value.percentage then
              table.insert(message_parts, ("%3d%%"):format(value.percentage))
            end

            if value.title then
              table.insert(message_parts, value.title)
            end

            if value.message then
              table.insert(message_parts, ("**%s**"):format(value.message))
            end

            client_progress[i] = {
              token = event.data.params.token,
              message = table.concat(message_parts, " "),
              done = value.kind == "end",
            }
            break
          end
        end

        local message = {} ---@type string[]
        progress_by_client[client.id] = vim.tbl_filter(function(v)
          return table.insert(message, v.message) or not v.done
        end, client_progress)

        local is_done = value.kind == "end"

        vim.notify(table.concat(message, "\n"), vim.log.levels.INFO, {
          id = "lsp_progress_" .. event.data.client_id,
          timeout = is_done and nil,
          title = client.name,
          opts = function(notification)
            notification.icon = #progress_by_client[client.id] == 0
                and symbols.progress.done
              or symbols.progress.get_dynamic_spinner()
          end,
        })
      end,
    })
  end,
}
