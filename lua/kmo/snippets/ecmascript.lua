-- cspell:words luasnip

local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local for_in = s(
  {
    name = "Modern for-in loop",
    trig = "mforin", -- cspell:disable-line
    desc = "A modern version of the existing for-in loop snippet",
  },
  fmt(
    [[
      for (const {key} in {object}) {{
        if (Object.hasOwn({object_rep}, {key_rep})) {{
          const {element} = {object_rep}[{key_rep}];
          {body}
        }}
      }}
    ]],
    {
      key = i(1, "key"),
      key_rep = rep(1),
      object = i(2, "object"),
      object_rep = rep(2),
      element = i(3, "element"),
      body = i(0),
    }
  )
)

local is_not_instanceof = s(
  {
    name = "Not instanceof",
    trig = "ninst", -- cspell:disable-line
    desc = "A check to throw an error, when a variable is not an instance of a type",
  },
  fmt(
    [[
      if (!({variable} instanceof {type})) {{
        throw new Error("'{variable_rep}' was not an instance of '{type_rep}'.");
      }}
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

local langs =
  { "javascript", "javascriptreact", "typescript", "typescriptreact" }

for _, lang in ipairs(langs) do
  ls.add_snippets(lang, {
    for_in,
    is_not_instanceof,
  })
end
