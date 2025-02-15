local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local is_not_instanceof = s(
  {
    name = "Not instanceof",
    trig = "ninst",
    desc = "A check to throw an error, when a variable is not an instance of a type.",
  },
  fmt(
    [[
      if (!({variable} instanceof {type}))
        throw new Error("'{variable_rep}' was not an instance of '{type_rep}'.");
    ]],
    {
      variable = i(1),
      type = c(2, {
        i(nil, "HTMLElement"),
        sn(nil, { t "HTML", i(1), t "Element" }),
      }),
      variable_rep = rep(1),
      type_rep = rep(2),
    }
  )
)

ls.add_snippets("javascript", {
  is_not_instanceof,
})
ls.add_snippets("typescript", {
  is_not_instanceof,
})
