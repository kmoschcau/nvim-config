local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

local spell = s(
  {
    name = "Spell settings",
    trig = "spell",
    desc = "Vim and cspell spelling language settings",
  },
  fmt(
    [[
      <!-- vim: set spelllang={spelllang}: -->
      <!-- cspell:dictionary {dictionary} -->
      <!-- cspell:words spelllang -->
    ]],
    {
      spelllang = i(1, "de,en"),
      dictionary = i(2, "de-de,en"),
    }
  )
)

local langs = { "markdown", "markdown_inline" }

for _, lang in ipairs(langs) do
  ls.add_snippets(lang, {
    spell,
  })
end
