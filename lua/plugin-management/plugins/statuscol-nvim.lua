-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require "statuscol.builtin"
    require("statuscol").setup {
      bt_ignore = { "help", "prompt", "quickfix", "terminal" },
      segments = {
        { text = { "%C" }, click = "v:lua.ScFa" },
        {
          sign = {
            name = { ".*" },
            namespace = { ".*" },
            maxwidth = 2,
            foldclosed = true,
          },
          click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        {
          sign = { namespace = { "gitsigns" }, maxwidth = 1, foldclosed = true },
          click = "v:lua.ScSa",
        },
      },
      clickhandlers = {
        ["todo%-"] = function(args)
          if args.button == "l" then
            local has_snacks, snacks = pcall(require, "snacks")
            if has_snacks then
              snacks.picker.todo_comments()
            end
          end
        end,
      },
    }
  end,
}
