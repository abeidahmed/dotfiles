local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.setup {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = false,
}

ls.add_snippets("all", {
  s("uuid", {
    f(function()
      local template ="xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
      return string.gsub(template, "[xy]", function (c)
        local v = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format("%x", v)
      end)
    end)
  })
})

ls.add_snippets("gitcommit", {
  s("coauthor", {
    c(1, {
      t { "Co-authored-by: Kevin Dias <diasks2@gmail.com>" },
      t { "Co-authored-by: Nate Hill <natanio@gmail.com>" },
      t { "Co-authored-by: Kurt Meyerhofer <k@kcmr.io>" },
    }),
  }),
})

vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>luasnip-next-choice", {})
