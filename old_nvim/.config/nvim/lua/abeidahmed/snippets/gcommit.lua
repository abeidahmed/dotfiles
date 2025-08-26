local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node

return {
  -- A list of all the coauthors
  s("coauthor", {
    c(1, {
      t { "Co-authored-by: Kevin Dias <diasks2@gmail.com>" },
      t { "Co-authored-by: Kurt Meyerhofer <k@kcmr.io>" },
      t { "Co-authored-by: nsoseka <lisaacjunior@yahoo.com>" },
      t { "Co-authored-by: JarredSKT <106943987+JarredSKT@users.noreply.github.com>" },
    }),
  }),
}
