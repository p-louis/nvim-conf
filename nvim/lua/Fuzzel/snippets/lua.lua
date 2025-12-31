local ls = require "luasnip"

local i = ls.insert_node
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmta

ls.add_snippets("lua", {
  s("nmap",
    fmt("vim.keymap.set('n', '<>', <>, { desc = '<>' })", { i(0, "keys"), i(1, "command"), i(2, "description") })),

  s("imap",
    fmt("vim.keymap.set('i', '<>', <>, { desc = '<>' })", { i(0, "keys"), i(1, "command"), i(2, "description") })),
})
