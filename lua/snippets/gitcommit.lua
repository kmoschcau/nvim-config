local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("gitcommit", {
  s({
    name = "chore: Plugins update",
    trig = "cpu",
    desc = "A conventional commit subject for a chore commit, updating plugins",
  }, { t { "chore(plugins): update", "", "" }, i(0) }),
})
