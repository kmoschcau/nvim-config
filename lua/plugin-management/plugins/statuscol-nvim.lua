-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require "statuscol.builtin"
    require("statuscol").setup {
      ft_ignore = { "ministarter" },
      bt_ignore = { "help", "prompt", "quickfix", "terminal" },
      segments = {
        { text = { "%C" }, click = "v:lua.ScFa" },
        {
          sign = {
            name = { ".*" },
            namespace = { ".*" },
            maxwidth = 9,
            auto = true,
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
            vim.cmd.TodoTelescope()
          end
        end,
      },
    }
  end,
}
