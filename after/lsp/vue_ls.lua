-- cspell:words vtsls

---@type vim.lsp.Config
return {
  on_init = function(client)
    client.handlers["tsserver/request"] = function(
      _,
      request_result,
      request_context
    )
      local clients =
        vim.lsp.get_clients { bufnr = request_context.bufnr, name = "vtsls" }
      if #clients == 0 then
        vim.notify(
          "There is no vtsls client attached to the buffer. vue_ls will not work without it.",
          vim.log.levels.ERROR
        )
        return
      end
      local ts_client = clients[1]

      local param = unpack(request_result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = "vue_request_forward",
        command = "typescript.tsserverRequest",
        arguments = { command, payload },
      }, { bufnr = request_context.bufnr }, function(_, response_result)
        local response_data = { { id, response_result.body } }
        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify("tsserver/response", response_data)
      end)
    end
  end,
}
