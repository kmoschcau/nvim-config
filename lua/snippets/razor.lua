-- cspell:words luasnip nameof

local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("razor", {
  s(
    {
      name = "foreach loop",
      trig = "foreach",
      desc = "A foreach loop.",
    },
    fmt(
      [[
        @foreach (var {element} in {enumerable})
        {{
          {body}
        }}
      ]],
      {
        element = i(1),
        enumerable = c(2, {
          i(nil, "Model"),
          sn(nil, { t "Model.", i(1) }),
          -- TODO: Expand with restore node.
          sn(nil, { i(1, "Model"), t ".", i(2) }),
        }),
        body = i(0),
      }
    )
  ),
  s(
    {
      name = "if statement",
      trig = "if",
      desc = "An if-statement.",
    },
    fmt(
      [[
        @if ({condition})
        {{
          {body}
        }}
      ]],
      { condition = i(1), body = i(0) }
    )
  ),
  s(
    {
      name = "asp-controller attribute",
      trig = "asp-c",
      desc = "An asp-controller attribute with a type-safe value.",
    },
    fmt(
      [[asp-controller="@(GetControllerName<{controller_name}{controller}>())"]],
      {
        controller_name = i(1),
        controller = i(2, "Controller"),
      }
    )
  ),
  s(
    {
      name = "asp-action attribute",
      trig = "asp-a",
      desc = "An asp-action attribute with a type-safe value.",
    },
    fmt([[asp-action="@(nameof({controller_name}{controller}.{action}))"]], {
      controller_name = i(1),
      controller = i(2, "Controller"),
      action = i(3, "Index"),
    })
  ),
  s(
    {
      name = "asp-route attribute",
      trig = "asp-r",
      desc = "An asp-route attribute.",
    },
    fmt([[asp-route-{name}="@{value}"]], {
      name = i(1, "id"),
      value = i(2),
    })
  ),
})
