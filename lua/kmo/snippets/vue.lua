-- cspell:words luasnip

local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescript", {
  s(
    {
      name = "Define props Typescript",
      trig = "vProps",
      desc = "A `defineProps` with Typescript syntax",
    },
    fmt(
      [[
        const {{}} = defineProps<{{
          {content}
        }}>();
      ]],
      {
        content = i(1),
      }
    )
  ),
})
